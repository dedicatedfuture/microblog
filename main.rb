require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
enable :sessions
#set the database
configure(:development){set :database, 'sqlite3:microblog.sqlite3'}

set :sessions, true
require './models/users'
require './models/posts'
require './models/followers'

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
    user_posts(@current_user)
  end
end

def post_all
  @posts = Post.all.reverse
end

def user_posts(x)
  user_id = x.id
  @user_posts = Post.where(user_id: user_id).reverse
end

get '/del' do
  current_user
  @current_user.destroy
  Follower.where(followed: @current_user.id).destroy_all
  Follower.where(following: @current_user.id).destroy_all
  session[:user_id] = nil
  redirect '/'
end

get '/post' do
  erb :posts
end
get '/postdel' do
  user_posts(params[:id])
  @user_posts.where(params[:id]).destroy
  redirect '/profile'
end
get '/postupdate' do
  user_posts(params[:id])
  @user_posts.where(params[:id]).update
  redirect '/profile'
end

post '/microsubmit' do
  current_user
  @user_id = @current_user.id
  @title = params[:title]
  @micro_blog = params[:microblog]

  @post = Post.create(title: @title, body: @micro_blog, user_id: @user_id, created: Time.now )
  redirect '/'
end

post '/follow' do
  Follower.create(followed: params[:followed], following: params[:following])
  flash[:notice] = "You are now following this user."
  redirect '/'
end

post '/unfollow' do
  Follower.where(followed: params[:followed],  following:  params[:following]).destroy_all
  flash[:notice] = "You are no longer following this user."
  redirect '/'
end

post '/direct_to_other_user_profile' do
  current_user
  @other_user = User.where(id: params[:other_user_id]).first
  @other_user_posts = Post.where(user_id: @other_user.id).reverse
  erb :other_user_profile
end
