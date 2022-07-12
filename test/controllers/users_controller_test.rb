require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_user_path
    assert_response :success
  end

  test 'should create a user' do
    stub_captcha_request(response: 'P0_eyiLCJhbGciOiJIUzI1NiJ9.FFIOURzRVh6WVhVVGk2dy', to_return: true)
    assert_difference('User.count') do
      post users_path, params: {
        user: {
          email: 'and@test.cl',
          password: 'Test12345',
          password_confirmation: 'Test12345'
        },
        "g-recaptcha-response": 'P0_eyiLCJhbGciOiJIUzI1NiJ9.FFIOURzRVh6WVhVVGk2dy'
      }
      assert_redirected_to home_path
    end
  end

  test 'should not create' do
    stub_captcha_request(response: 'P0_eyiLCJhbGciOiJIUzI1NiJ9.URzRVh6WVhVVGk2dy', to_return: true)
    assert_no_difference('User.count') do
      post users_path, params: {
        user: {
          email: 'and@test.cl',
          password: 'Test12345',
          password_confirmation: 'Test1345'
        },
        "g-recaptcha-response": 'P0_eyiLCJhbGciOiJIUzI1NiJ9.URzRVh6WVhVVGk2dy'
      }
    end
  end
end
