require 'rubygems'
require 'sinatra'

require 'erb'
require 'json'
set :views, File.dirname(__FILE__) + '/views'
set :public, File.dirname(__FILE__) + '/public' #for serving static files

require 'data_mapper'
require 'data_mapper'
DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'sqlite3::memory:')

class LevelStatus
  include DataMapper::Resource
  property :id, Serial
  property :italian, Float
  property :hairbender, Float
  property :decaf, Float
end

DataMapper.finalize
LevelStatus.auto_migrate!

#display charts
get '/' do
  @levels = LevelStatus.all
  erb :index
end

#ajax action to get currents levels
get '/get-current-levels' do
	content_type :json
	@levels = LevelStatus.last
  { :italian => @levels.italian, :hairbender => @levels.hairbender, :decaf => @levels.decaf }.to_json
end

get '/update-levels' do
  '<h1>Oops</h1><p>Only POST requests are allowed. To simulate POST requests, go to <a href="/simulate">/simulate</a></p>'
end

post '/update-levels' do
  @status = LevelStatus.create(
    :italian => params[:italian],
    :hairbender => params[:hairbender],
    :decaf => params[:decaf]
  )
  status 200
end

#simulate the arduino
get '/simulate' do
  erb :simulate
end
