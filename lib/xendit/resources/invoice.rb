# frozen_string_literal: true

require 'faraday'
require 'json'

require_relative '../api_operations'
require_relative '../response'

module Xendit
  class Invoice
    class << self
      def get(invoice_id)
        # validation
        raise ArgumentError, 'invoice_id is required and should be a string' \
            if invoice_id.nil? || !invoice_id.is_a?(String)

        resp = Xendit::ApiOperations.get "v2/invoices/#{invoice_id}"
        Xendit::Response.handle_error_response resp

        JSON.parse resp.body
      end

      # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
      def create(invoice_params)
        # validation
        raise ArgumentError, 'invoice body payload is required' \
            if invoice_params.nil? || invoice_params.empty?
        raise ArgumentError, 'payer_email is required and should be a string' \
            if invoice_params[:payer_email].nil? ||
               !invoice_params[:payer_email].is_a?(String)
        raise ArgumentError, 'external_id is required and should be a string' \
            if invoice_params[:external_id].nil? ||
               !invoice_params[:external_id].is_a?(String)
        raise ArgumentError, 'description is required and should be a string' \
            if invoice_params[:description].nil? ||
               !invoice_params[:description].is_a?(String)
        raise ArgumentError, 'amount is required and should be an integer or float' \
            if invoice_params[:amount].nil? ||
               (!invoice_params[:amount].is_a?(Integer) &&
               !invoice_params[:amount].is_a?(Float))

        resp = Xendit::ApiOperations.post('v2/invoices', **invoice_params)
        Xendit::Response.handle_error_response resp

        JSON.parse resp.body
      end
      # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity

      def expire(invoice_id)
        # validation
        raise ArgumentError, 'invoice_id is required and should be a string' \
            if invoice_id.nil? || !invoice_id.is_a?(String)

        resp = Xendit::ApiOperations.post "invoices/#{invoice_id}/expire!"
        Xendit::Response.handle_error_response resp

        JSON.parse resp.body
      end

      def get_all(filter_params = nil)
        resp = Xendit::ApiOperations.get('v2/invoices', filter_params)
        Xendit::Response.handle_error_response resp

        JSON.parse resp.body
      end
    end
  end
end
