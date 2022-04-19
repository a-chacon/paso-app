class PagesController < ApplicationController

  include RailsUrlShortener::UrlsHelper

  def home
    if !params[:url].nil?
      flash.now[:notice] = short_url(params[:url], expires_at: Time.now + 12.hour)
      render turbo_stream: turbo_stream.update("flash", partial: "shared/flash")
    end
  end

end
