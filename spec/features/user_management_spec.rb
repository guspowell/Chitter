require 'spec_helper'

feature 'User signs up' do

	scenario 'When being a new user visiting the site' do
		expect{ sign_up }.to change(User, :count).by(1)
		expect(page).to have_content("Welcome, test")
		user = User.first
		expect(user.username).to eq("test")
	end

	scenario "with a password that doesn't match" do
    expect{ sign_up('a@a.com', 'pass', 'wrong') }.to change(User, :count).by(0)
    expect(current_path).to eq('/users')
    expect(page).to have_content("Sorry, your passwords don't match")
  end


	def sign_up(email = "test@test.com",
							username = "test",
							password = "1234",
							password_confirmation = "1234")
		visit('/users/new')
		expect(page.status_code).to eq(200)
		fill_in 'username', :with => username
		fill_in 'password', :with => password
		fill_in 'password_confirmation', :with => password_confirmation
		click_button 'Sign up'
	end

end