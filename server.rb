require 'data_mapper'
require 'sinatra/base'

require './lib/post'
require './lib/user'

class Chitter < Sinatra::Base

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

DataMapper.finalize

DataMapper.auto_upgrade!

enable :essions
set :sessions_secret, 'super secret'

	get '/' do
		@posts = Post.all
		erb :index
	end

	post '/post' do
		content = params["content"]
		Post.create(:content => content)
		redirect to('/')
	end

	get '/users/new' do
		erb :"users/new"
	end

	post '/users' do
		@email = params[:email]
		@password = params[:password]
		@username = params[:username]
		user = User.create(:username => @username,
										:email => @email,
										:password => params[:password])
		session[:user_id] = user.id
		puts current_user.username.inspect
		redirect to('/')
	end

	helpers do

		def current_user
			@current_user ||= User.get(session[:user_id]) if session[:user_id]
		end

	end

end