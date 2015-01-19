require 'spec_helper'

feature "user adds a new post" do

  before(:each) do
    User.create(:email => "test@test.com",
    						:username => 'test',
                :password => '1234',
                :password_confirmation => '1234')
  end

	scenario "when browsing the home page" do
		sign_in('test', '1234')
		expect(Post.count).to eq(0)
		add_post("This is my first post")
		expect(Post.count).to eq(1)
		post = Post.first
		expect(post.content).to eq("This is my first post")
	end

	def add_post(content)
		fill_in 'content', :with => content
		save_and_open_page
		click_button 'submit'
	end

end