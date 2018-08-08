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
<<<<<<< HEAD


# nohup ruby ./server.rb -p 4567 -o 10.0.25.247 >> ./logs/log_file.txt 2>&1 &
=======
>>>>>>> 51e678c54e07b5680e76025cecde6b0d1712fd29
