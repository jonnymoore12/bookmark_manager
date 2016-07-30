ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/flash'
require 'pry'

class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  get '/users/login' do
    erb :'users/login'
  end

  post '/users/login' do
    user = User.authenticate(params[:email], params[:password])
    binding.pry
    if user
      session[:user_id] = user.id
      flash.now[:sign_in] = ["Welcome, you have signed in as #{user.email}"]
      redirect '/links'
    else
      flash.now[:errors] = ['The email or password is incorrect']
      erb :'/users/login'
    end
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.create(url: params[:url], title: params[:title])

    params[:tags].split.each do |tag|
      link.tags << Tag.first_or_create(name: tag)
    end

    link.save
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users/new' do
    @user = User.new(email: params[:email], password: params[:password], password_repeat: params[:password_repeat])
    if(@user.save)
      session[:user_id] = @user.id
      redirect '/links'
    else
      flash.now[:warning] = @user.errors.full_messages
      erb :'/users/new'
    end
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
