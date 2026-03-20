module Home
  class IndexData
    Result = Struct.new(:featured_products, keyword_init: true)

    def self.call
      new.call
    end

    def call
      Result.new(
        featured_products: Product.where(featured: true)
      )
    end
  end
end
