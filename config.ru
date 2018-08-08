$stdout.reopen('./logs/log_file.txt', 'a')
$stdout.sync = true

require File.expand_path('server.rb', File.dirname(__FILE__))

run Sinatra::Application
