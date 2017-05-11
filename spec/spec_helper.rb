require 'simplecov'
require "codeclimate-test-reporter"

CodeClimate::TestReporter.start
SimpleCov.start do
  add_filter '/spec'
end if ENV["COVERAGE"]

require File.expand_path("../../lib/intelipost", __FILE__)
require 'intelipost'
require 'dotenv'
require 'vcr'

Dotenv.load

VCR.configure do |c|
  c.default_cassette_options = { record: :new_episodes }
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock, :faraday
  c.configure_rspec_metadata!
  c.ignore_hosts 'codeclimate.com'

  c.before_record do |i|
    i.request.headers.delete('api_key')
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = 'random'
end
