require 'sinatra/activerecord'
# require 'sinatra/activerecord/rake'
require './server.rb'

begin
#     require 'rspec/core/rake_task'
    RSpec::Core::RakeTask.new(:spec)
    task default: :spec
rescue => exception
    # rspec not available
end
