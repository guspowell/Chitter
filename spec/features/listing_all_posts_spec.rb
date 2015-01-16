require 'spec_helper'

feature "User browses the list of posts" do

	before(:each) {
		Post.create(:content => "Hello Gus")
	}

	scenario "When opening the home page" do
		visit '/'
		expect(page).to have_content("Hello Gus")
	end

end