require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'generate a short url' do
    assert_difference('RailsUrlShortener::Url.count') do
      post '/generate?url=https://a-chacon.com'
    end
    url = RailsUrlShortener::Url.last
    assert_redirected_to "/#{url.key}/visits"
  end

  test 'input and invalid url' do
    assert_no_difference('RailsUrlShortener::Url.count') do
      post '/generate?url=a-chacon'
    end
    assert_equal 'It is not a valid url.', flash[:error]
  end
end
