require 'sinatra'
require 'sinatra/mongomapper'

# Mongo mapper settings
set :mongomapper, 'mongomapper://localhost:27017/mongotesttest-example'
set :mongo_logfile, File.join("log", "mongo-driver-#{settings.environment}.log")

get '/' do
  "Mongo log file: #{settings.mongo_logfile}"
end