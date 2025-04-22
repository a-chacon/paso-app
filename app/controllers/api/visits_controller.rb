module Api
  class VisitsController < BaseController
    # @tags Visits
    # @response Success (200) [Array<RailsUrlShortener::Visit>]
    # @response Error (404) [Hash]
    #   {
    #     error: String
    #   }
    def index
      url = RailsUrlShortener::Url.unexpired.find_by(id: params[:url_id], owner: Current.user)
      if url
        visits = url.visits.order(id: :desc).includes(:ipgeo)
        render json: visits, status: :ok
      else
        render json: { error: 'Short URL not found or expired' }, status: :not_found
      end
    end

    # @tags Visits
    # @response Success (200) [RailsUrlShortener::Visit]
    # @response Error (404) [Hash
    #   {
    #     error: String
    #   }
    #   ]
    def show
      visit = RailsUrlShortener::Visit.find_by(id: params[:id])
      if visit && visit.url.owner == Current.user
        render json: visit, status: :ok
      else
        render json: { error: 'Visit not found or unauthorized' }, status: :not_found
      end
    end
  end
end
