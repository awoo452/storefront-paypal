class Product < ApplicationRecord
    has_many :product_variants, dependent: :destroy
    has_many :vendor_products, through: :product_variants
    has_many :vendors, through: :vendor_products
    before_validation :assign_price_from_vendors
    before_validation :set_slug, on: :create
    before_destroy :delete_s3_images
    after_commit :refresh_pricing_from_vendors, on: :update, if: :pricing_inputs_changed?

    validates :name, presence: true
    validates :price, presence: true, unless: :price_hidden?
    validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
    validates :margin_percent, numericality: { greater_than_or_equal_to: 0, less_than: 100 }, allow_nil: true
    validates :handling_fee, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
    validates :slug, presence: true, uniqueness: true
    validate :pricing_ready, unless: :price_hidden?

    def set_slug
        self.slug = name.parameterize if slug.blank? && name.present?
    end

    def image_url
        return nil if image_key.blank?
        S3Service.new.presigned_url(image_key)
    end

    def image_alt_url
        return nil if image_alt_key.blank?
        S3Service.new.presigned_url(image_alt_key)
    end

    def image_keys
        [ image_key, image_alt_key ].compact
    end

    def image_variant_keys
        image_keys
    end

    def update_pricing_from_vendors!
        product_variants.each(&:apply_pricing!)
        refresh_price_from_variants!
    end

    def recalculate_pricing!
        update_pricing_from_vendors!
    end

    private

    def pricing_inputs_changed?
        saved_change_to_margin_percent? || saved_change_to_handling_fee?
    end

    def assign_price_from_vendors
        return if margin_percent.blank?

        prices = product_variants.map(&:suggested_price).compact
        return if prices.empty?

        self.price = prices.min
    end

    def pricing_ready
        active_variants = product_variants.select(&:active?)
        if active_variants.empty?
          errors.add(:base, "Add at least one active variant before publishing pricing.")
          return
        end

        missing = active_variants.select { |variant| variant.suggested_price.nil? }
        return if missing.empty?

        names = missing.map(&:name).join(", ")
        errors.add(:base, "Pricing missing for variants: #{names}. Add vendor costs and ensure margin is set.")
    end

    def refresh_pricing_from_vendors
        recalculate_pricing!
    end

    def refresh_price_from_variants!
        prices = product_variants.map(&:suggested_price).compact
        return if prices.empty?

        new_price = prices.min
        return if price.present? && price.to_d == new_price.to_d

        update!(price: new_price)
    end

    def delete_s3_images
        key = image_key.presence || image_alt_key.presence
        return if key.blank?
        return if ENV["AWS_BUCKET"].blank?

        prefix = key.sub(/(main|alt)\..*$/, "")
        S3Service.new.delete_prefix(prefix)
    rescue StandardError => e
        Rails.logger.error("S3 delete failed for product #{id}: #{e.message}")
    end
end
