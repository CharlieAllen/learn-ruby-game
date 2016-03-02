ENV['RACK_ENV'] = 'test'

require "./bin/app.rb"
require "test/unit"
require "rack/test"

class TestName < Test::Unit::TestCase

	def test_sample
		assert_equal(4, 2+2)
	end

end

class MyAppTest < Test::Unit::TestCase
	include Rack::Test::Methods

	def app
		Sinatra::Application
	end

	def test_default()
	  get '/'
	  follow_redirect!

	  assert_equal "http://example.org/game", last_request.url
	  assert last_response.ok?
	  assert_equal last_request.session[:room], "START"
	end

	def test_game_death()
	end

end

