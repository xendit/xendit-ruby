# frozen_string_literal: true

require_relative './xendit'

# Check your current balance
begin
  balance = Xendit::Balance.get_balance
  puts "\nBalance::"
  puts balance
rescue Xendit::APIError => e
  puts e
end