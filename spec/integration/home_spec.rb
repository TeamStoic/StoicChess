require 'spec_helper'
require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe 'home page' do
  it 'welcomes the user' do
    visit '/'
    page.should have_content('StoicChess')
  end
end

describe "the signin process", :type => :feature do
  before :each do
    User.create(:email => 'user@example.com', :password => 'password')
  end

  it "signs me in" do
    visit '/users/sign_in'
    fill_in 'Email', :with => 'user@example.com'
    fill_in 'Password', :with => 'password'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end

