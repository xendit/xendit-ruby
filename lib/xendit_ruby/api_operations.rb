# frozen_string_literal: true

require 'faraday'
require 'json'
require 'active_support'

module XenditRuby
  class ApiOperations
    class << self
      def get(url, params: nil)
        conn = create_connection
        conn.get url, params
      end

      private

      def create_connection
        Faraday.new(
          url: XenditRuby.base_url,
          headers: {'Content-Type' => 'application/json'}
        ) do |conn|
          conn.basic_auth(XenditRuby.api_key, '')
        end
      end
    end
  end
end
