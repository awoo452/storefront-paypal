VendorProduct.destroy_all
ProductVariant.destroy_all
Product.destroy_all
Vendor.destroy_all

vendor = Vendor.create!(
  name: "Example Supply Co.",
  contact_name: "Alex Vendor",
  email: "sales@example.com",
  phone: "555-0100",
  website: "https://example.com",
  active: true
)

product = Product.create!(
  name: "Sample Tee",
  description: "Soft cotton tee for storefront demos.",
  margin_percent: 40,
  handling_fee: 2,
  featured: true,
  price_hidden: true
)

variant = ProductVariant.create!(
  product: product,
  name: "Standard",
  stock: 12,
  active: true
)

VendorProduct.create!(
  vendor: vendor,
  product_variant: variant,
  vendor_sku: "TEE-STD",
  unit_cost: 15,
  msrp: 30,
  min_order_quantity: 1,
  lead_time_days: 7
)

product.update!(price_hidden: false)
