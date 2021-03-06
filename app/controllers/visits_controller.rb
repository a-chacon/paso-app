class VisitsController < ApplicationController
  def index
    @url = RailsUrlShortener::Url.unexpired.find_by(key: params[:key])
    @visits = @url.visits.order(id: :desc).includes(:ipgeo) if @url
  end

  def show
    @url = RailsUrlShortener::Url.unexpired.find_by(key: params[:key])
    @visit = RailsUrlShortener::Visit.find(params[:id])
  end
end
