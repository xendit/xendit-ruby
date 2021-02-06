# frozen_string_literal: true

require 'faraday'
require 'json'
require 'active_support'

require_relative '../api_operations'

module Xendit
  class Invoice
    class << self
      def get(invoice_id)
        # validation
        raise ArgumentError, 'invoice_id is required and should be a string' \
            if invoice_id.blank? || !invoice_id.is_a?(String)

        resp = Xendit::ApiOperations.get "v2/invoices/#{invoice_id}"
        JSON.parse resp.body
      end
    end
  end
end
