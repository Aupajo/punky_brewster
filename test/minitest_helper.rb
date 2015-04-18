$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'punky_brewster'
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "test/fixtures/vcr_cassettes"
  config.hook_into :webmock
end
