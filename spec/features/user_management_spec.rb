require 'spec_helper'

feature 'User signs up' do

	scenario 'When being a new user visiting the site' do
		expect{ sign_up }.to change(User, :count).by(1)
		expect(page).to have_content("Welcome, test")
		user = User.first
		expect(user.username).to eq("test")
	end

	scenario 'With a password that does not match' do
		expect{ sign_up('gus@test.com', 'test', 'right', 'wrong') }.to change(User, :count).by(0)
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