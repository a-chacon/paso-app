require 'test_helper'

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  test 'new' do
    get login_url
    assert_response :success
  end

  test 'new with auth user' do
    sign_in_as(:one)
    get login_url
    assert_redirected_to home_path
  end

  test 'create' do
    # login is already implemented in the helper
    sign_in_as(:one)
    assert session[:user_id]
    assert_equal session[:user_id], users(:one).id
  end

  test 'recaptcha not valid or mission' do
    @user = users(:one)
    stub_captcha_request(response: 'P0_eyiLCJhbGciOiJIUzI1NiJ9.JwYXUpkNFFIOURzRVh6WVhVVGk2dy', to_return: false)
    post '/auth/login', params: {
      email: @user.email,
      password: 'Test12345',
      "g-recaptcha-response": 'P0_eyiLCJhbGciOiJIUzI1NiJ9.JwYXUpkNFFIOURzRVh6WVhVVGk2dy'
    }
    assert !flash['errors'].empty?
  end

  test 'destroy' do
    sign_in_as(:one)
    assert session[:user_id]
    get logout_path
    assert_nil session[:user_id]
  end
end
