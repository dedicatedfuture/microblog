require 'sinatra'
require 'sinatra/activerecord'

#set the database
set :database, 'sqlite3:microblog.sqlite3'

require './models/users'
require './models/posts'

get '/' do
  erb :home
end

get '/signup' do
  erb :signup
end
