# frozen_string_literal: true

require 'faraday'
require 'json'
require 'active_support'

require_relative '../api_operations'
require_relative '../response'

module Xendit
  class Invoice
    class << self
      def get(invoice_id)
        # validation
        raise ArgumentError, 'invoice_id is required and should be a string' \
            if invoice_id.blank? || !invoice_id.is_a?(String)

        resp = Xendit::ApiOperations.get "v2/invoices/#{invoice_id}"
        Xendit::Response.handle_error_response resp

        JSON.parse resp.body
      end

      # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/MethodLength, Metrics/PerceivedComplexity
      def create(invoice_params)
        # validation
        raise ArgumentError, 'invoice body payload is required' \
            if invoice_params.blank?
        raise ArgumentError, 'payer_email is required and should be a string' \
            if invoice_params[:payer_email].blank? ||
               !invoice_params[:payer_email].is_a?(String)
        raise ArgumentError, 'external_id is required and should be a string' \
            if invoice_params[:external_id].blank? ||
               !invoice_params[:external_id].is_a?(String)
        raise ArgumentError, 'description is required and should be a string' \
            if invoice_params[:description].blank? ||
               !invoice_params[:description].is_a?(String)
        raise ArgumentError, 'amount is required and should be a number' \
            if invoice_params[:amount].blank? ||
               (!invoice_params[:amount].is_a?(Integer) &&
               !invoice_params[:amount].is_a?(Float))
        raise ArgumentError, 'should_send_email should be a boolean' \
            if !invoice_params[:should_send_email].blank? &&
               (!invoice_params[:should_send_email].nil? != invoice_params[:should_send_email])
        raise ArgumentError, 'callback_virtual_account_id should be a string' \
            if !invoice_params[:callback_virtual_account_id].blank? &&
               !invoice_params[:callback_virtual_account_id].is_a?(String)
        raise ArgumentError, 'invoice_duration should be a string' \
            if !invoice_params[:invoice_duration].blank? &&
               !invoice_params[:invoice_duration].is_a?(Integer)
        raise ArgumentError, 'success_redirect_url should be a string' \
            if !invoice_params[:success_redirect_url].blank? &&
               !invoice_params[:success_redirect_url].is_a?(String)
        raise ArgumentError, 'failure_redirect_url should be a string' \
            if !invoice_params[:failure_redirect_url].blank? &&
               !invoice_params[:failure_redirect_url].is_a?(String)
        raise ArgumentError, 'mid_label should be a string' \
            if !invoice_params[:mid_label].blank? &&
               !invoice_params[:mid_label].is_a?(String)
        raise ArgumentError, 'currency should be a string' \
            if !invoice_params[:currency].blank? && !invoice_params[:currency].is_a?(String)
        raise ArgumentError, 'fixed_va should be a boolean' \
            if !invoice_params[:fixed_va].blank? &&
               (!invoice_params[:fixed_va].nil? != invoice_params[:fixed_va])
        raise ArgumentError, 'reminder_time should be a number' \
            if !invoice_params[:reminder_time].blank? &&
               !invoice_params[:reminder_time].is_a?(Integer)
        raise ArgumentError, 'payment_methods should be an array' \
            if !invoice_params[:payment_methods].blank? &&
               !invoice_params[:payment_methods].is_a?(Array)

        resp = Xendit::ApiOperations.post('v2/invoices', **invoice_params)
        Xendit::Response.handle_error_response resp

        JSON.parse resp.body
      end
      # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/MethodLength, Metrics/PerceivedComplexity
    end
  end
end
