module Api
  class BaseController < ActionController::API
    include ApiAuthentication
  end
end
