require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test 'get the home' do
    get '/'
    assert_response :success
  end

  test 'generate a short url' do
    assert_difference("RailsUrlShortener::Url.count") do
      post '/?url=https://a-chacon.com'
    end
    url = RailsUrlShortener::Url.last
    assert_redirected_to "/#{url.key}/visits"
  end

  test 'input and invalid url' do
    assert_no_difference("RailsUrlShortener::Url.count") do
      post '/?url=a-chacon'
    end
    assert_equal "It is not a valid url.", flash[:error]
  end
end
