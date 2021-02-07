# frozen_string_literal: true

require_relative './errors'

module Xendit
  class Response
    class << self
      def handle_error_response(resp)
        return unless resp.status >= 400

        body = JSON.parse resp.body
        raise Xendit::APIError.new(body['error_code'], body['message'], resp.status)
      end
    end
  end
end
