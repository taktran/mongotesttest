require 'sinatra'
require 'mongo_mapper'
require 'uri'
require 'sass'

set :environment, ENV["RACK_ENV"] || "development"

##############################################################################
# Mongo mapper settings
##############################################################################
def setup_mongo_connection(mongo_url)
  url = URI(mongo_url)
  MongoMapper.connection = Mongo::Connection.new(url.host, url.port)
  MongoMapper.database = url.path.gsub(/^\//, '')
  MongoMapper.database.authenticate(url.user, url.password) if url.user && url.password
end
if settings.environment == "production"
  # From heroku settings: http://devcenter.heroku.com/articles/mongolab
  setup_mongo_connection(ENV['MONGOLAB_URI'])
elsif settings.environment == "development"
  setup_mongo_connection('mongomapper://localhost:27017/mongotesttest-example')
end
##############################################################################


class TeamMember
  include MongoMapper::Document

  key :first_name, String
  key :last_name, String
end

get '/' do
  erb :index
end

# Bad practice to do this in get request but hey, this is a hack
get '/create' do
  TeamMember.create(:first_name => "Billy", :last_name => "Corgan")
  
  redirect '/'
end

# Bad practice to do this in get request but hey, this is a hack
get '/delete' do
  first_billy = TeamMember.find_by_first_name('Billy')
  first_billy.destroy unless first_billy.nil?
  
  redirect '/'
end

get '/stylesheets/:stylesheet.css' do
  scss "sass/#{params[:stylesheet]}".intern
end
