# frozen_string_literal: true

require_relative './xendit'

# Check your current balance
begin

  # create invoice
  refund_params = {
    invoice_id: '63652c5aeb10cf6e95053d1a',
    reference_id: 'Hello Refunds',
    reason: 'CANCELLATION',
    currency: 'PHP',
    amount: 10_000,
  }
  created_refund = Xendit::Refund.create refund_params
  puts "\nCreated Refund::"
  puts created_refund

  # get invoice
  refund = Xendit::Refund.get created_refund['id']
  puts "\nRefund::ID"
  puts refund

  # get all invoices
  filter_params = {
    limit: 2
  }
  refund = Xendit::Refund.get_all filter_params
  puts "\nRefund::"
  puts refund
rescue Xendit::APIError => e
  puts e
end