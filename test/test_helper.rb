require "minitest/cc"
Minitest::Cc.start

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def sign_in_as(name)
    @user = users(name)
    post '/auth/login', params: {
      email: @user.email,
      password: 'Test12345'
    }
  end

  def create_a_url
    @url = RailsUrlShortener::Url.create(
      url: 'https://api.rubyonrails.org/v4.1.9/classes/Rails/Generators/Migration.html#method-i-migration_template',
      key: 'as12as', category: 'docs'
    )
    @browser = Browser.new('Mozilla/5.0 (X11; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0')
    @url.visits << RailsUrlShortener::Visit.create(
      ip: '1.1.1.1', browser: @browser.name, browser_version: @browser.full_version,
      platform: @browser.platform.name, platform_version: @browser.platform.version, bot: @browser.bot?,
      user_agent: 'Mozilla/5.0 (X11; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0'
    )
  end
end
