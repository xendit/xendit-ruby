# frozen_string_literal: true

require 'faraday'
require 'json'
require 'active_support'

module Xendit
  class ApiOperations
    class << self
      def get(url, params: nil)
        conn = create_connection
        conn.get url, params
      end

      def post(url, **params)
        conn = create_connection
        conn.post url, JSON.generate(params)
      end

      private

      def create_connection
        Faraday.new(
          url: Xendit.base_url,
          headers: {'Content-Type' => 'application/json'}
        ) do |conn|
          conn.basic_auth(Xendit.api_key, '')
        end
      end
    end
  end
end
