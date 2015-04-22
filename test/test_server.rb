require 'minitest_helper'
require 'rack/test'
require 'punky_brewster/server'

class TestServer < Minitest::Test
  include Rack::Test::Methods

  def test_json_content_type
    assert_equal 'application/json', server_response['Content-Type']
  end

  def test_json_includes_all_beers
    assert_equal 21, response_json.length
  end

  def test_beer_json
    expected = {
      'name' => 'EPIC PALE ALE',
      'price' => 14,
      'abv' => 5.4,
      'image_url' => 'http://www.punkybrewster.co.nz/uploads/3/7/6/2/37625085/7550425.jpg?74'
    }

    assert_equal expected, response_json.first
  end

  def test_error_response
    VCR.use_cassette("broken") { get "/" }
    assert_equal 'application/json', last_response['Content-Type']
    refute JSON.parse(last_response.body)['error'].empty?
  end

  def app
    PunkyBrewster::Server
  end

  def server_response
    make_request
    last_response
  end

  def response_json
    JSON.parse(server_response.body)
  end

  def make_request
    VCR.use_cassette("whats-pouring") { get "/" }
  end
end
