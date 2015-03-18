require 'data_mapper'
require 'sinatra/base'
require 'rack-flash'

require './lib/post'
require './lib/user'

class Chitter < Sinatra::Base

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

DataMapper.finalize

DataMapper.auto_upgrade!

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash
use Rack::MethodOverride

	get '/' do
		@posts = Post.all(:order => [ :created_at.desc])
		erb :index
	end

	post '/post' do
		content = params["content"]
		Post.create(:content => content, :user_id => session[:user_id], :created_at => Time.now)
		redirect to('/')
	end

	get '/users/new' do
	  @user = User.new
	  erb :"users/new"
	end

	post '/users' do
	  @user = User.new(:email => params[:email],
	              		 :password => params[:password],
	              		 :username => params[:username],
	              		 :password_confirmation => params[:password_confirmation])
		if @user.save
		  session[:user_id] = @user.id
		  redirect to('/')
		else
		  flash.now[:errors] = @user.errors.full_messages
		  erb :"users/new"
		end
	end

	get '/sessions/new' do
	  erb :"sessions/new"
	end

	post '/sessions' do
		username, password = params[:username], params[:password]
		user = User.authenticate(username, password)
		if user
			session[:user_id] = user.id
			redirect to('/')
		else
			flash[:errors] = ["The email or password is incorrect"]
			erb :"sessions/new"
		end
	end

	delete '/sessions' do
    flash[:notice] = 'Good bye!'
    session[:user_id] = nil
    redirect to('/')
  end

	helpers do
	  def current_user
	    @current_user ||=User.get(session[:user_id]) if session[:user_id]
	  end
	end

end
