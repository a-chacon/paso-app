require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'create a valid user' do
    user = User.new(email: 'unique@test.cl', password: 'Test12345', password_confirmation: 'Test12345')
    assert user.save
  end

  test 'update' do
    user = users(:one)
    assert user.update(email: 'aa@aa.cl')
  end

  test 'require password confirmation on create' do
    user = User.create(email: 'unique@test.cl', password: 'Test12345')
    assert_equal :blank, user.errors.where(:password_confirmation).first.type
  end

  test 'password confirmation on create' do
    user = User.create(email: 'unique@test.cl', password: 'Test123', password_confirmation: 'Test12345')
    assert_equal :confirmation, user.errors.where(:password_confirmation).first.type
  end

  test 'uniquess of email' do
    user = User.create(email: 'one@test.cl', password: 'Test12345', password_confirmation: 'Test12345')
    assert_equal :taken, user.errors.where(:email).first.type
  end

  test 'valid email' do
    user = User.create(email: 'oneeetest.cl', password: 'Test12345', password_confirmation: 'Test12345')
    assert_equal :invalid, user.errors.where(:email).first.type
  end

  test 'related to urls' do
    user = users(:one)
    user.urls << RailsUrlShortener::Url.new(
      url: 'https://api.rubyonrails.org/v4.1.9/classes/Rails/Generators/Migration.html#method-i-migration_template',
      key: 'as12as',
      category: 'docs'
    )
    assert_equal 1, user.urls.count
  end
end
