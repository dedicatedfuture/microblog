require 'sinatra'
require 'sinatra/activerecord'

#set the database
set :database, 'sqlite3:microblog.sqlite3'

# require '.model/users'
