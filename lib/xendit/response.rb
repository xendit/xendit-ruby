# frozen_string_literal: true

require_relative './errors'

module Xendit
  class Response
    class << self
      def handle_error_response(resp)
        # validation
        raise ArgumentError, 'response is required' \
            if resp.nil?
        raise ArgumentError, 'response is in invalid format' \
            if resp.status.nil? && resp.body.nil?

        return unless resp.status >= 400

        body = JSON.parse resp.body
        raise Xendit::APIError.new(body['error_code'], body['message'], resp.status)
      end
    end
  end
end
