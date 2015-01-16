require 'spec_helper'

feature "User browses the list of posts" do

	before(:each) {
		Post.create(:content => "Hello Gus",
								:time => "a")
	}

	scenario "When opening the home page" do
		visit '/'
		expect(page).to have_content("Hello Gus")
		expect(page).to have_content("a")
	end

end