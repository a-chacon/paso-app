# config/initializers/oas_rails.rb
#
OasRails::Engine.middleware.use(Rack::Auth::Basic) do |username, password|
  ActiveSupport::SecurityUtils.secure_compare(Rails.application.credentials.oas_rails_username, username) &
    ActiveSupport::SecurityUtils.secure_compare(Rails.application.credentials.oas_rails_password, password)
end

OasRails.configure do |config|
  # Basic Information about the API
  config.info.title = 'Paso: Simplify Your Links and Track Visitors'
  config.info.version = '1.0.0'
  config.info.summary = 'A URL Shortener with advanced analytics for tracking traffic through your links. Create short URLs, manage them, and analyze visitor data.'
  config.info.description = <<~HEREDOC
    # Welcome to Paso API Documentation

    Paso is a URL Shortener with advanced analytics for tracking traffic through your links. This API allows you to create short URLs, manage them, and analyze visitor data, including geolocation, browser, OS, and more.

    ## API Documentation Purpose

    This interactive documentation provides a comprehensive guide to the Paso API endpoints, enabling developers to:
    - Generate and manage short URLs.
    - Retrieve detailed analytics about link visits.
    - Authenticate and manage user accounts.

    ## Getting Started

    To use the Paso API:
    1. Authenticate using the provided security schema (Bearer token).
    2. Explore the endpoints below to interact with the API.
    3. Refer to the response schemas for expected data formats.

    ## Features

    - **URL Shortening**: Create short links for easy sharing.
    - **Visitor Analytics**: Track detailed information about each visit, including:
      - IP and geolocation data.
      - User agent details (browser, OS, bot detection).
    - **Authentication**: Secure access to endpoints using JWT tokens.

    ## Documentation Structure

    - **Tags**: Endpoints are grouped by functionality (e.g., Users, URLs, Visits).
    - **Schemas**: Detailed request and response models for each endpoint.
    - **Examples**: Sample requests and responses to help you integrate quickly.

    For more details about the project, visit the [Paso landing page](https://paso.fly.dev) or contribute to the [RailsUrlShortener engine](https://github.com/a-chacon/rails_url_shortener).

    **This API documentation is generated with [OasRails](https://github.com/a-chacon/oas_rails)**
  HEREDOC
  config.info.contact.name = 'a-chacon'
  config.info.contact.email = 'andres.ch@proton.me'
  config.info.contact.url = 'https://a-chacon.com'

  # Servers Information. For more details follow: https://spec.openapis.org/oas/latest.html#server-object
  config.servers = [
    { url: 'https://paso.fly.dev', description: 'Remote' },
    { url: 'http://localhost:3000', description: 'Local' }
  ]

  # Tag Information. For more details follow: https://spec.openapis.org/oas/latest.html#tag-object
  config.tags = [
    { name: 'Users', description: 'Manage the `amazing` Users table.' }
  ]

  # Optional Settings (Uncomment to use)

  # Extract default tags of operations from namespace or controller. Can be set to :namespace or :controller
  config.default_tags_from = :controller

  # Automatically detect request bodies for create/update methods
  # Default: true
  # config.autodiscover_request_body = false

  # Automatically detect responses from controller renders
  # Default: true
  # config.autodiscover_responses = false

  # API path configuration if your API is under a different namespace
  config.api_path = '/api'

  # Apply your custom layout. Should be the name of your layout file
  # Example: "application" if file named application.html.erb
  # Default: false
  # config.layout = "application"

  # Excluding custom controllers or controllers#action
  # Example: ["projects", "users#new"]
  # config.ignored_actions = []

  # #######################
  # Authentication Settings
  # #######################

  # Whether to authenticate all routes by default
  # Default is true; set to false if you don't want all routes to include security schemas by default
  config.authenticate_all_routes_by_default = true

  # Default security schema used for authentication
  # Choose a predefined security schema
  # [:api_key_cookie, :api_key_header, :api_key_query, :basic, :bearer, :bearer_jwt, :mutual_tls]
  config.security_schema = :bearer

  # Custom security schemas
  # You can uncomment and modify to use custom security schemas
  # Please follow the documentation: https://spec.openapis.org/oas/latest.html#security-scheme-object
  #
  # config.security_schemas = {
  #  bearer:{
  #   "type": "apiKey",
  #   "name": "api_key",
  #   "in": "header"
  #  }
  # }

  # ###########################
  # Default Responses (Errors)
  # ###########################

  # The default responses errors are set only if the action allow it.
  # Example, if you add forbidden then it will be added only if the endpoint requires authentication.
  # Example: not_found will be setted to the endpoint only if the operation is a show/update/destroy action.
  # config.set_default_responses = true
  # config.possible_default_responses = [:not_found, :unauthorized, :forbidden, :internal_server_error, :unprocessable_entity]
  # config.response_body_of_default = "Hash{ message: String }"
  # config.response_body_of_unprocessable_entity= "Hash{ errors: Array<String> }"
  # config.rapidoc_theme = :olive
end
