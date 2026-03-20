# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.3] - 2026-03-20
### Changed
- Updated dependencies: aws-sdk-s3 1.217.0, minitest 6.0.2, bootsnap 1.23.0.
- Relaxed the minitest constraint to allow the 6.x line.

## [0.0.2] - 2026-03-20
### Changed
- Updated dependencies: turbo-rails 2.0.23, solid_queue 1.3.2, thruster 0.1.19, web-console 4.3.0, kamal 2.11.0, devise 5.0.3, selenium-webdriver 4.41.0.
- Updated GitHub Actions to actions/checkout v6 and actions/upload-artifact v7.

## [0.0.1] - 2026-03-20
### Added
- Storefront template with products, variants, cart, PayPal checkout, and orders.
- Vendor pricing workflow with margin/handling auto pricing.
- S3 product image integration using the main/alt key conventions.
- Sample seed data for a vendor, product, variant, and pricing link.
- Default storefront placeholder image for products without uploaded assets.
