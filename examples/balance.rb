# frozen_string_literal: true

require_relative './xendit'

# Check your current balance
begin
    # create invoice
    invoice_params = {
      external_id: 'demo_147580196270',
      payer_email: 'sample_email@xendit.co',
      description: 'Trip to Bali',
      amount: 10_000_000
    }
    created_invoice = Xendit::Invoice.create invoice_params
    puts "\nCreated Invoice::"
    puts created_invoice
    
  balance = Xendit::Balance.get_balance
  puts "\nBalance::"
  puts balance
rescue Xendit::APIError => e
  puts e
end