class PagesController < ApplicationController
  include RailsUrlShortener::UrlsHelper

  def home
    unless params[:url].nil?
      # only redirect to the visits page
      redirect_to "#{short_url(params[:url], expires_at: Time.now + 12.hour)}/visits"
    end
  end
end
