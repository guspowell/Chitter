require 'spec_helper'

describe Post do

	context 'Demonstration of how datamapper works' do
		it 'should be created and then retrieved from the db' do
			expect(Post.count).to eq(0)
			Post.create(content: 'Hello Gus')
			expect(Post.count).to eq(1)
			post = Post.first
			expect(post.content).to eq('Hello Gus')
			post.destroy
			expect(Post.count).to eq(0)
		end
	end


	

end

