require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "User browses the list of posts" do

	before(:each) {
		Post.create(:content => "Hello Gus")
		User.create(:email => "test@test.com",
								:username => 'test',
								:password => '1234',
								:password_confirmation => '1234')
	}

	scenario "When opening the home page" do
		visit '/'
		sign_in("test", "1234")
		fill_in "content", :with => "Hello Gus"
		click_button "submit"
		expect(page).to have_content("Hello Gus")
	end

end
