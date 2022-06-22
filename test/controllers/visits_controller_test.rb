require 'test_helper'

class VisitsControllerTest < ActionDispatch::IntegrationTest
  test 'should show a url' do
    create_a_url
    get "/#{@url.key}/visits"
    assert_response :success
  end

  test 'should list all visits for a url' do
    create_a_url
    get "/#{@url.key}/visits/#{@url.visits.first.id}"
    assert_response :success
  end
end
