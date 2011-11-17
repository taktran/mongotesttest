require 'sinatra'
require 'sinatra/mongomapper'

# Mongo mapper settings
set :mongomapper, 'mongomapper://localhost:27017/mongotesttest-example'
set :mongo_logfile, File.join("log", "mongo-driver-#{settings.environment}.log")

class TeamMember
  include MongoMapper::Document

  key :first_name, String
  key :last_name, String
end

get '/' do
  TeamMember.create(:first_name => "Billy", :last_name => "Corgan")
  first_billy = TeamMember.find_by_first_name('Billy')
  output = "<p>Billy who? #{first_billy.last_name}</p>"
  
  billys = TeamMember.find_all_by_first_name('Billy')
  output += "<p>Count: #{billys.length}</p>"
  
  output
end
