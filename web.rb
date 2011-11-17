require 'sinatra'
require 'sinatra/mongomapper'

# Mongo mapper settings
if settings.environment == :production
  settings[ENV['RACK_ENV']]["uri"] = ENV['MONGOLAB_URI']
  MongoMapper.config = settings
  MongoMapper.connect(ENV['RACK_ENV'])
elsif settings.environment = :development
  set :mongomapper, 'mongomapper://localhost:27017/mongotesttest-example'
end
set :mongo_logfile, File.join("log", "mongo-driver-#{settings.environment}.log")

class TeamMember
  include MongoMapper::Document

  key :first_name, String
  key :last_name, String
end

get '/' do
  output = ""
  
  first_billy = TeamMember.find_by_first_name('Billy')
  if first_billy.present?
    output = "<p>Billy who? #{first_billy.last_name}</p>"
  
    billys = TeamMember.find_all_by_first_name('Billy')
    output += "<p>Count: #{billys.length}</p>"
  end
  
  output += "<p><a href='/create'>Create another Corgan</a></p>"
  output += "<p><a href='/delete'>Delete</a></p>"
  
  output
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
