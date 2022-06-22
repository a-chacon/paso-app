require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test 'main' do
    get '/'
    assert_response :success
  end

  test 'home without session' do
    get '/home'
    assert_redirected_to root_path
  end

  test 'home' do
    sign_in_as(:one)
    get '/home'
    assert_response :success
  end

  test 'generate without session' do
    get '/generate'
    assert_redirected_to root_path
  end

  test 'generate' do
    sign_in_as(:one)
    get '/generate'
    assert_response :success
  end
end
