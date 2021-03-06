# frozen_string_literal: true

require_relative 'lib/xendit/version'

Gem::Specification.new do |spec|
  spec.name    = 'xendit'
  spec.version = Xendit::VERSION

  spec.summary = 'Xendit Ruby API client library'

  spec.authors  = ['@yongquanben']
  spec.email    = 'benjamin@xendit.co'
  spec.homepage = 'https://github.com/xendit/xendit-ruby'
  spec.licenses = ['MIT']

  spec.required_ruby_version = '>= 2.5'

  spec.files = Dir['README.md', '{examples,lib,spec}/**/*.rb',
                   'xendit.gemspec',
                   'Gemfile', 'Rakefile']

  spec.executables << 'xendit'

  spec.add_dependency 'faraday', '~> 1.3'

  spec.add_development_dependency 'rake', '~> 13.0'

  spec.add_development_dependency 'rubocop', '~> 1.9'
  spec.add_development_dependency 'rubocop-performance', '~> 1.9'

  spec.add_development_dependency 'rspec', '~> 3.6'
end
