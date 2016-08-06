# controller for static pages
class StaticPagesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to games_path
    end
  end
end
