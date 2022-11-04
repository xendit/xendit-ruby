# frozen_string_literal: true

require_relative './xendit'
require 'xendit'
require 'net/http'
require 'uri'
require 'json'

begin
  # create invoice
  invoice_params = {
    external_id: 'demo_147580196270',
    payer_email: 'sample_email@xendit.co',
    description: 'Trip to Bali',
    amount: 10_000
  }
  created_invoice = Xendit::Invoice.create invoice_params
  puts "\nCreated Invoice::"
  puts created_invoice


  # get invoice
  invoice = Xendit::Invoice.get created_invoice['id']
  puts "\nInvoice::"
  puts invoice

  # expire invoice
  # expired_invoice = Xendit::Invoice.expire created_invoice['id']
  # puts "\nExpired Invoice::"
  # puts expired_invoice

  # get all invoices
  filter_params = {
    limit: 2
  }
  invoices = Xendit::Invoice.get_all filter_params
  puts "\nInvoices::"
  puts invoices
rescue Xendit::APIError => e
  puts e
end
