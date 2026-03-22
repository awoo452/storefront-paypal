# Storefront PayPal Template

Reference Rails app for a storefront with vendor-managed pricing, cart, and PayPal checkout.

## Features

- Products with variants, inventory, and featured flags.
- Vendor pricing links and auto-calculated margin/handling pricing.
- Cart flow with PayPal order creation + capture.
- Orders admin queue with line items.
- Tax + shipping calculations.

### S3 Image Dependency

This template follows the exact S3 conventions from `templates/s3-image-storage`. Product images are stored in S3 and referenced by key:

- Main image: `products/<slug>/main.<ext>`
- Alt image: `products/<slug>/alt.<ext>`

Use the S3 template docs for setup and proxy configuration:

- `templates/s3-image-storage/README.md`
- `templates/s3-image-storage/docs/IMAGE_STRATEGY.md`
- `templates/s3-image-storage/docs/IMAGE_PROXY.md`

### Admin Access

1. Create a user via sign-up.
2. In the Rails console:
   ```ruby
   user = User.find_by(email: "you@example.com")
   user.update!(admin: true)
   ```
3. Visit `/admin` to manage products, vendors, and orders.

### Storefront Workflow

1. Create a vendor (Admin → Vendors).
2. Create a product and set margin/handling.
3. Add variants with stock and active flags.
4. Link vendor pricing to variants (Admin → Vendor pricing).
5. Upload main/alt images for the product.

Products are purchasable when at least one active variant has stock and pricing. Leave variant stock blank to mark it out of stock.

### Cart, Shipping, and Tax

- Cart requires sign-in.
- Shipping is `$5` for the first item + `$4` per additional item.
- Bulky variants add `$5` each.
- Tax is pulled from the `tax_rates` table (default state in `Cart::Pricing` is `WA`).

## Setup

Required environment variables:

- `AWS_REGION` (or `AWS_DEFAULT_REGION`)
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_BUCKET`
- `PAYPAL_CLIENT_ID`
- `PAYPAL_SECRET`
- `PAYPAL_ENV` (defaults to `sandbox`, use `live` for production)

Optional (production mailers):

- `APP_HOST`
- `MAILER_FROM`

Local setup:

1. `bundle install`
2. `bin/rails db:prepare`

## Run

1. `bin/dev`

## Tests

1. `bin/rails test`

## Changelog

See [`CHANGELOG.md`](CHANGELOG.md) for notable changes.
