module Api
  class UsersController < BaseController
    allow_unauthenticated_access only: [:create]

    # @summary Create a User
    # @tags Users
    # @no_auth
    # @request_body User attributes
    #   [
    #     Hash{ user: {
    #       name: String,
    #       email: String,
    #       password: String,
    #       password_confirmation: String
    #     }}
    #   ]
    # @request_body_example Valid user [Hash]
    #   { user: {
    #       name: "John Doe",
    #       email: "john@example.com",
    #       password: "password123",
    #       password_confirmation: "password123"
    #   }}
    # @response Success (201) [Hash{message: String, user: User}]
    def create
      user = User.create(user_params)

      if user.errors.empty?
        render json: { message: 'User created successfully', user: user }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # @summary Update a User
    # @tags Users
    # @request_body User attributes [Hash]
    #   {
    #     name: String,
    #     email: String,
    #     password: String,
    #     password_confirmation: String
    #   }
    # @request_body_example Valid user [Hash]
    #   {
    #     name: "John Doe Updated",
    #     email: "john.updated@example.com",
    #     password: "newpassword123",
    #     password_confirmation: "newpassword123"
    #   }
    # @response Success (200) [Hash{message: String, user: User}]
    def update
      if Current.user.update(user_params)
        render json: { message: 'User updated successfully', user: Current.user }, status: :ok
      else
        render json: { errors: Current.user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
end
