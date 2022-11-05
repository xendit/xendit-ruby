# frozen_string_literal: true

require 'faraday'
require 'json'

require_relative '../api_operations'
require_relative '../response'

module Xendit
  class Refund
    class << self
      def get(refund_id)
        # validation
        raise ArgumentError, 'invoice_id is required and should be a string' \
            if refund_id.nil? || !refund_id.is_a?(String)

        resp = Xendit::APIOperations.get "/refunds/#{refund_id}"
        Xendit::Response.handle_error_response resp

        JSON.parse resp.body
      end

      # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
      def create(refund_params)
        # validation
        raise ArgumentError, 'refunds body payload is required' \
            if refund_params.nil? || refund_params.empty?
        raise ArgumentError, 'invoice_id is required and should be a string' \
            if refund_params[:invoice_id].nil? ||
               !refund_params[:invoice_id].is_a?(String)
        raise ArgumentError, 'reason is required and should be a string eg:[FRAUDULENT,DUPLICATE, REQUESTED_BY_CUSTOMER, CANCELLATION,OTHERS] ' \
            if refund_params[:reason].nil? ||
               !refund_params[:reason].is_a?(String)
        raise ArgumentError, 'currency is required and should be a string eg:[PHP, IDR]' \
            if refund_params[:currency].nil? ||
               !refund_params[:currency].is_a?(String)
        raise ArgumentError, 'amount is required and should be an integer or float' \
            if refund_params[:amount].nil? ||
               (!refund_params[:amount].is_a?(Integer) &&
               !refund_params[:amount].is_a?(Float))

        resp = Xendit::APIOperations.post('/refunds', **refund_params)
        Xendit::Response.handle_error_response resp

        JSON.parse resp.body
      end
      def get_all(filter_params = nil)
        resp = Xendit::APIOperations.get('/refunds', filter_params)
        Xendit::Response.handle_error_response resp

        JSON.parse resp.body
      end
    end
  end
end