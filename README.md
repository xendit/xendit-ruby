# Xendit API Ruby Library

This library is the abstraction of Xendit API for access from applications written with Ruby/Rails.

<!-- toc -->

- [API Documentation](#api-documentation)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
  * [Invoice Service](#invoice-service)

<!-- tocstop -->

## API Documentation

Please check [Xendit API Reference](https://xendit.github.io/apireference/).

## Requirements
- Ruby 2.5+.

## Installation
Add this line to your application’s Gemfile:
```bash
gem 'xendit'
```
And then execute:
```bash
$ bundle
```
Access the library in Ruby/Rails project:
```ruby
require 'xendit'
```

## Usage

First, start by setting up with your account's **secret key** obtained from your [Xendit Dashboard](https://dashboard.xendit.co/settings/developers#api-keys).
Once done, you are ready to use all services provided in this library.

```ruby
require 'xendit'

# Provide api key
Xendit.api_key = 'xnd_...'
```

### Invoice Service

Refer to [Xendit API Reference](https://xendit.github.io/apireference/#invoices) for more info about methods' parameters

Create an invoice
```ruby
# setup invoice details
invoice_params = {
    external_id: 'demo_147580196270',
    payer_email: 'sample_email@xendit.co',
    description: 'Trip to Bali',
    amount: 10_000_000
}
# create an invoice
created_invoice = Xendit::Invoice.create invoice_params
```

Get an invoice
```ruby
# get an invoice
invoice = Xendit::Invoice.get '5efda8a20425db620ec35f43'
```

Get all invoices
```ruby
# setup filters
filter_params = {
    limit: 3
}
# get invoices
invoices = Xendit::Invoice.get_all filter_params
```

Expire an invoice
```ruby
# expire an invoice
expired_invoice = Xendit::Invoice.expire '5efda8a20425db620ec35f43'
```