# frozen_string_literal: true

require_relative 'xendit/resources'

XENDIT_BASE_URL = 'https://api.xendit.co/'

module Xendit
  class << self
    attr_accessor :api_key
    attr_writer :base_url

    def base_url
      @base_url ||= XENDIT_BASE_URL
    end
  end
end
