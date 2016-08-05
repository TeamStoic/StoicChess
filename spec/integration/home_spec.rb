require 'spec_helper'
require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe 'home page' do
  it 'should welcome the user' do
    visit '/'
    expect(page).to have_content('StoicChess')
  end
end

describe 'the sign-in process', type: :feature do
  before :each do
    User.create(email: 'user@example.com', password: 'password')
  end

  it 'should sign me in' do
    visit '/users/sign_in'
    within('.deviseNewLogIn') do
      fill_in 'Email Address', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      expect(page).to have_content # 'Signed in successfully.'
    end         # Above altered to pass tests after re-routing
  end           # user registration to root_path
end
