class VisitsController < ApplicationController

  def index
    print(Rails.application.routes.named_routes.helper_names)
    @url = RailsUrlShortener::Url.unexpired.where(owner: nil).find_by(key: params[:key])
    @visits = @url.visits.order(id: :desc) unless !@url
  end

end
