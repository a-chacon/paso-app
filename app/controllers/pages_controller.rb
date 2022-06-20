class PagesController < ApplicationController
  before_action :require_authentication, except: [:main]

  def main; end

  # this page will be show all short urls created by a user and will redirect to visits pages
  def home
    @urls = @current_user.urls.includes(:visits)
  end

  def generate; end
end
