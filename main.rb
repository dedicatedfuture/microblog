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
  post_all
  current_user

  erb :home
end

get '/signup' do
  current_user
  erb :signup
end

get '/profile' do
  user_posts
  current_user
  erb :profile
end

get '/about' do
  erb :about
end

get '/account' do
  current_user
  erb :account
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end

post '/submitted' do
   @user_fname = params[:fname]
   @user_lname = params[:lname]
   @user_email = params[:email]
   @user_name = params[:uname]
   @user_description = params[:description]
   @user_password = params[:password]
   @user = User.create(fname: @user_fname, lname: @user_lname, email: @user_email, username: @user_name, description: @user_description, password: @user_password, joined: Time.now )
   redirect '/account'
end

post '/update' do
  current_user
  @user_fname = params[:fname]
  @user_lname = params[:lname]
  @user_email = params[:email]
  @user_name = params[:uname]
  @user_description = params[:description]
  @user_password = params[:password]
  @current_user.update(fname: @user_fname, lname: @user_lname, email: @user_email, username: @user_name, description: @user_description, password: @user_password )
  redirect '/account'
end

post '/sign-in' do
  @user = User.where(email: params[:email]).first
  if @user && @user.password === params[:password]
    session[:user_id] = @user.id
    @logged_in = true
    flash[:notice] = "terrific sign in"
    redirect '/'
  elsif @user && @user.email === params[:email]
    flash[:notice] = "Invalid Password"
    redirect '/'
  else
    flash[:notice] = "User not in our system, please sign up!"
    redirect '/'
  end
end

def current_user
  if session[:user_id]
    @current_user = User.find(session[:user_id])
  end
end

def post_all
  @posts = Post.all.reverse
end

def user_posts
  current_user
  user_id = @current_user.id
  @user_posts = Post.where(user_id: user_id).reverse
end

get '/del' do
  current_user
  @current_user.destroy
  session[:user_id] = nil
  redirect '/'
end

get '/post' do
  erb :posts
end


post '/microsubmit' do
  current_user
  @user_id = @current_user.id
  @title = params[:title]
  @micro_blog = params[:microblog]

  @post = Post.create(title: @title, body: @micro_blog, user_id: @user_id, created: Time.now )
  redirect '/'

end
