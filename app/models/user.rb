class User < ApplicationRecord
  has_many :urls, class_name: 'RailsUrlShortener::Url', as: 'owner'
  has_many :sessions

  has_secure_password

  validates :email, uniqueness: true, on: :create
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, presence: true, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  ## Authenticate a user with email and password
  # @param email [String] Email of user.
  # @param password [String] Password encrypted of user.
  # @return [User] the user object.
  def self.authenticate(email: String, password: String)
    find_by(email: email)&.authenticate(password)
  end
end
