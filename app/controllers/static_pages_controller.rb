# controller for static pages
class StaticPagesController < ApplicationController
  def index
    redirect_to games_path if user_signed_in?
  end
end
