require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require 'rspec/core/rake_task'
require './server.rb'

begin
    RSpec::Core::RakeTask.new(:spec)
    task default: :spec
rescue => exception
    # rspec not available
end
