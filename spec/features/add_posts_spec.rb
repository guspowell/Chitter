require 'spec_helper'

feature "user adds a new post" do

	scenario "when browsing the home page" do
		visit '/'
		expect(Post.count).to eq(0)
		add_post("This is my first post")
		expect(Post.count).to eq(1)
		post = Post.first
		expect(post.content).to eq("This is my first post")
	end

	def add_post(content)
		fill_in 'content', :with => content
		click_button 'submit'
	end

end