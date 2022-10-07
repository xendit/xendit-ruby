# frozen_string_literal: true

require_relative '../lib/xendit' # require 'xendit'

Xendit.api_key = 'xnd_development_A3wzUff7RUheGs2LkrRFA3KAmErOgFq1sBar3guZ5a1MeGHLRZhYXgoRzOb7V'

# environment variables
puts "\nXendit API Key"
puts Xendit.api_key

puts "\nXendit API URL"
puts Xendit.base_url # change url if needed
