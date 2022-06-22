require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_user_path
    assert_response :success
  end

  test 'should create a user' do
    assert_difference('User.count') do
      post users_path, params: {
        user: {
          email: 'and@test.cl',
          password: 'Test12345',
          password_confirmation: 'Test12345'
        }
      }
      assert_redirected_to home_path
    end
  end

  test 'should not create' do
    assert_no_difference('User.count') do
      post users_path, params: {
        user: {
          email: 'and@test.cl',
          password: 'Test12345',
          password_confirmation: 'Test1345'
        }
      }
    end
  end
end
