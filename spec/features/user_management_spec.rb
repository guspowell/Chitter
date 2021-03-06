require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature 'User signs up' do

	scenario 'When being a new user visiting the site' do
		expect{ sign_up }.to change(User, :count).by(1)
		expect(page).to have_content("Welcome, test")
		user = User.first
		expect(user.username).to eq("test")
	end

	scenario "with a password that doesn't match" do
    expect{ sign_up('a@a.com', 'a', 'pass', 'wrong') }.to change(User, :count).by(0)
    expect(current_path).to eq('/users')
    expect(page).to have_content("Password does not match the confirmation")
  end

  scenario "with a username that is already registered" do
  	expect{ sign_up }.to change(User, :count).by(1)
  	expect{ sign_up }.to change(User, :count).by(0)
  	expect(page).to have_content("Username is already taken")
  end

end
