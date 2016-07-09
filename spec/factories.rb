# FactoryGirl.define do
#   factory :user do
#     email 'test@example.com'
#     password 'f4k3p455w0rd'

#   end
# end

require "rails_helper"
include Warden::Test::Helpers
Warden.test_mode!

describe "the signin process", :type => :feature do
  before :each do
    User.create(:email => 'user@example.com', :password => 'password')
  end

  it "signs me in" do
    visit '/users/sign_in'
    # within("/users/sign_in") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'password'
    # end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end