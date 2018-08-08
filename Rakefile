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
# nohup ruby ./server.rb -p 4567 -o 10.0.25.247 >> ./logs/log_file.txt 2>&1 &

