require 'rubygems'
require 'sinatra'
require 'erb'

set :views, File.dirname(__FILE__) + '/views'
set :public, File.dirname(__FILE__) + '/public' #for serving static files

#display charts
get '/' do
  erb :index
end

#ajax action to get currents levels
get '/get-current-levels' do
	#get values from database
  erb :index
end

post '/update-levels' do
  params.inspect
  status 200
end

#simulate the arduino
get '/simulate' do
  erb :simulate
end
