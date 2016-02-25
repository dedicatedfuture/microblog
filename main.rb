require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
enable :sessions
#set the database
configure(:development){set :database, 'sqlite3:microblog.sqlite3'}

set :sessions, true
require './models/users'
require './models/posts'

get '/' do
  erb :home
end

get '/signup' do

  erb :signup
end

get '/about' do
  erb :about
end

get '/profile' do
  current_user
  erb :profileview
end

post '/submitted' do
   @user_fname = params[:fname]
   @user_lname = params[:lname]
   @user_email = params[:email]
   @user_name = params[:uname]
   @user_description = params[:description]
   @user_date = params[:joined]
   @user_password = params[:password]
   @user = User.create(fname: @user_fname, lname: @user_lname, email: @user_email, username: @user_name, description: @user_description, joined: @user_date, password: @user_password )
   redirect '/'
end

post '/sign-in' do
  @user = User.where(email: params[:email]).first
  if @user && @user.password === params[:password]
    session[:user_id] = @user.id
    @logged_in = true
    flash[:notice] = "terrific sign in"
    redirect '/'
   end
end

def current_user
  if session[:user_id]
   @current_user = User.find(session[:user_id])
  end
end
