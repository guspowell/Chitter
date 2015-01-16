require 'data_mapper'
require 'sinatra/base'

require './lib/post'

class Chitter < Sinatra::Base

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

DataMapper.finalize

DataMapper.auto_upgrade!


	get '/' do
		@posts = Post.all
		erb :index
	end

	post '/post' do
		content = params["content"]
		Post.create(:content => content)
		redirect to('/')
	end



end