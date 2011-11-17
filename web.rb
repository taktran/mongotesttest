require 'sinatra'
require 'sinatra/mongomapper'

set :mongomapper, 'mongomapper://localhost:27017/mongotesttest-example'

# Specify a logger to be used by the MongoDB driver
# Value can be any that the Logger accepts for initialization
# The following is the default setting
environment = "development"
set :mongo_logfile, File.join("log", "mongo-driver-environment.log")

get '/' do
  "hello ya ya ya"
end