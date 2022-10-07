# frozen_string_literal: true

require 'faraday'
require 'json'

require_relative '../api_operations'
require_relative '../response'

module Xendit
  class CreditCard
    class << self

      def create_token(cc_params)
        # validation
        raise ArgumentError, 'CC body payload is required' \
            if cc_params.nil? || cc_params.empty?
      end


    end
  end
end