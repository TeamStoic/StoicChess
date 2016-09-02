require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'static_pages#index' do
    it 'should successfully load the homepage' do
      get :index, method: :post
      expect(response).to have_http_status(:success)
    end
    it 'should redirect user to games page if they are signed_in' do
      user = FactoryGirl.create(:user)
      sign_in user

      get :index, method: :get
      expect(response).to redirect_to games_path
    end
  end
end
