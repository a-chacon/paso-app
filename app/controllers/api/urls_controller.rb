module Api
  class UrlsController < BaseController
    # @summary List Short Urls
    # @tags Urls
    # @response List of Urls(200) [Array<RailsUrlShortener::Url>]
    def index
      urls = Current.user.urls.includes(:visits)
      render json: urls, status: :ok
    end

    # @summary Create Short Urls
    # @tags Urls
    # @request_body A valid Url [Hash{ url: String }]
    # @request_body_example Valid URL [Hash]
    #   {
    #     url: "https://example.com/long-url"
    #   }
    # @response Success(201) [Hash{url: RailsUrlShortener::Url}]
    def create
      url = RailsUrlShortener::Url.generate(params[:url], owner: Current.user)
      if url.persisted?
        render json: { message: 'Short URL created successfully', url: url }, status: :created
      else
        render json: { errors: url.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # @summary Destroy Urls
    # @tags Urls
    # @response Success (200) [Hash{ message: String }]
    def destroy
      url = RailsUrlShortener::Url.find_by(id: params[:id], owner: Current.user)
      if url&.destroy
        render json: { message: 'Short URL deleted successfully' }, status: :ok
      else
        render json: { error: 'Short URL not found or could not be deleted' }, status: :not_found
      end
    end
  end
end
