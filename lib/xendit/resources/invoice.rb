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
        raise ArgumentError, 'amount is required and should be an integer or float' \
            if invoice_params[:amount].blank? ||
               (!invoice_params[:amount].is_a?(Integer) &&
               !invoice_params[:amount].is_a?(Float))
        raise ArgumentError, 'should_send_email should be a boolean' \
            if !invoice_params[:should_send_email].blank? &&
               (!invoice_params[:should_send_email].nil? != invoice_params[:should_send_email])
        raise ArgumentError, 'callback_virtual_account_id should be a string' \
            if !invoice_params[:callback_virtual_account_id].blank? &&
               !invoice_params[:callback_virtual_account_id].is_a?(String)
        raise ArgumentError, 'invoice_duration should be an integer' \
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
        raise ArgumentError, 'reminder_time should be an integer' \
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

      def expire(invoice_id)
        # validation
        raise ArgumentError, 'invoice_id is required and should be a string' \
            if invoice_id.blank? || !invoice_id.is_a?(String)

        resp = Xendit::ApiOperations.post "invoices/#{invoice_id}/expire!"
        Xendit::Response.handle_error_response resp

        JSON.parse resp.body
      end

      # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/MethodLength, Metrics/PerceivedComplexity
      def get_all(filter_params = nil)
        # validation
        raise ArgumentError, 'statuses should be an array' \
            if !filter_params[:statuses].blank? &&
               !filter_params[:statuses].is_a?(Array)
        raise ArgumentError, 'limit should be an integer' \
            if !filter_params[:limit].blank? &&
               !filter_params[:limit].is_a?(Integer)
        raise ArgumentError, 'created_after should be a string in ISO 8601 format YYYY-MM-DDTHH:mm:ss.SSSZ' \
            if !filter_params[:created_after].blank? &&
               !filter_params[:created_after].is_a?(String)
        raise ArgumentError, 'created_before should be a string in ISO 8601 format YYYY-MM-DDTHH:mm:ss.SSSZ' \
            if !filter_params[:created_before].blank? &&
               !filter_params[:created_before].is_a?(String)
        raise ArgumentError, 'paid_after should be a string in ISO 8601 format YYYY-MM-DDTHH:mm:ss.SSSZ' \
            if !filter_params[:paid_after].blank? &&
               !filter_params[:paid_after].is_a?(String)
        raise ArgumentError, 'paid_before should be a string in ISO 8601 format YYYY-MM-DDTHH:mm:ss.SSSZ' \
            if !filter_params[:paid_before].blank? &&
               !filter_params[:paid_before].is_a?(String)
        raise ArgumentError, 'expired_after should be a string in ISO 8601 format YYYY-MM-DDTHH:mm:ss.SSSZ' \
            if !filter_params[:expired_after].blank? &&
               !filter_params[:expired_after].is_a?(String)
        raise ArgumentError, 'expired_before should be a string in ISO 8601 format YYYY-MM-DDTHH:mm:ss.SSSZ' \
            if !filter_params[:expired_before].blank? &&
               !filter_params[:expired_before].is_a?(String)
        raise ArgumentError, 'last_invoice_id should be a string' \
            if !filter_params[:last_invoice_id].blank? &&
               !filter_params[:last_invoice_id].is_a?(String)
        raise ArgumentError, 'client_types should be an array' \
            if !filter_params[:client_types].blank? &&
               !filter_params[:client_types].is_a?(Array)
        raise ArgumentError, 'payment_channels should be an array' \
            if !filter_params[:payment_channels].blank? &&
               !filter_params[:payment_channels].is_a?(Array)
        raise ArgumentError, 'on_demand_link should be a string' \
            if !filter_params[:on_demand_link].blank? &&
               !filter_params[:on_demand_link].is_a?(String)
        raise ArgumentError, 'recurring_payment_id should be a string' \
            if !filter_params[:recurring_payment_id].blank? &&
               !filter_params[:recurring_payment_id].is_a?(String)

        resp = Xendit::ApiOperations.get('v2/invoices', filter_params)
        Xendit::Response.handle_error_response resp

        JSON.parse resp.body
      end
      # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/MethodLength, Metrics/PerceivedComplexity
    end
  end
end
