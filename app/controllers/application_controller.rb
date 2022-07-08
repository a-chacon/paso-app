class ApplicationController < ActionController::Base
  include RailsUrlShortener::UrlsHelper
  require 'uri'
  require 'http'
  require 'json'

  before_action :current_user

  def generate
    if params[:url] =~ URI::DEFAULT_PARSER.make_regexp
      redirect_url = if @current_user
                       "#{short_url(params[:url], owner: @current_user)}/visits"
                     else
                       "#{short_url(params[:url], expires_at: Time.now + 12.hour)}/visits"
                     end
      redirect_to redirect_url, allow_other_host: true
    else
      flash.now[:error] = 'It is not a valid url.'
      render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash')
    end
  end

  def current_user
    @current_user ||= session[:user_id] &&
                      User.find_by(id: session[:user_id])
  end

  def require_authentication
    redirect_to root_url if @current_user.nil?
  end

  def verify_captcha
    data = { 'secret': ENV['SECRET_KEY'], 'response': params[:"g-recaptcha-response"] }

    response = HTTP.post(ENV['VERIFY_URL'], form: data)
    response_json = JSON.parse(response)

    return if ActiveModel::Type::Boolean.new.cast(response_json['success'])

    flash.now[:errors] = [OpenStruct.new(attribute: 'hCaptcha', message: 'Could not be verify')]
    render turbo_stream: turbo_stream.update('errors', partial: 'shared/errors')
  end
end
