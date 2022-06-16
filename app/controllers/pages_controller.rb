class PagesController < ApplicationController
  include RailsUrlShortener::UrlsHelper
  require 'uri'

  def home
    unless params[:url].nil?
      if params[:url] =~ URI::regexp
        # Correct URL
        redirect_to "#{short_url(params[:url], expires_at: Time.now + 12.hour)}/visits", allow_other_host: true
      else
        flash.now[:error] = "It is not a valid url."
        render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash')
      end
    end
  end
end
