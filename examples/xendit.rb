# frozen_string_literal: true

require_relative '../lib/xendit' # require 'xendit'

# Add api key
# Linux and MacOs:
# export API_KEY="API_KEY"
# Windows:
# set API_KEY="your_api_key"
# 
Xendit.api_key = ENV['API_KEY']

# environment variables
puts "\nXendit API Key"
puts Xendit.api_key

puts "\nXendit API URL"
puts Xendit.base_url # change url if needed