$stdout.repoen('./logs/log_file.txt', 'a')
$stdout.sync = true

loop.with_index do |_, i|
    puts i
    sleep(3)
end

# nohup ruby ./server.rb -p 4567 -o 10.0.25.247 >> ./logs/log_file.txt 2>&1 &