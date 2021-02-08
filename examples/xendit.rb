# frozen_string_literal: true

require_relative '../lib/xendit' # require 'xendit'

Xendit.api_key = 'your_api_key'

# environment variables
puts "\nXendit API Key"
puts Xendit.api_key

puts "\nXendit API URL"
puts Xendit.base_url # change url if needed
