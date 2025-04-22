module Api
  class AuthenticationController < BaseController
    allow_unauthenticated_access only: [:create]

    # @tags Authentication
    # @no_auth
    # @summary Create Auth Token
    # This is the method for log in to the system and use the others endpoints.
    # Before use it **you must have an active user registered in database**.
    # @request_body Credentials - Send a valid **email** and **password** credentials.
    #   [
    #     Hash{
    #       email: String,
    #       password: String
    #     }
    #   ]
    # @request_body_example Valid credentials [Hash]
    #   {
    #     email: "test@paso.app",
    #     password: "Test123"
    #   }
    # @response Successfull login(200)
    #   [
    #     Hash{
    #       message: String,
    #       user: User,
    #       token: String
    #     }
    #   ]
    def create
      if (user = User.authenticate_by(email: params[:email], password: params[:password]))
        start_new_session_for user
        render json: { message: 'Logged in successfully', user: user, token: Current.session.token }, status: :ok
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end

    # @summary Destroy Auth Token
    # @tags Authentication
    def destroy
      Current.update(active: false)

      render json: { message: 'Logged out successfully' }, status: :ok
    end
  end
end
