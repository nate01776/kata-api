nohup ruby ./server.rb -p 4567 -o 10.0.25.247 >> ../logs/log_file.txt 2>&1 &

echo $! > ./logs/server.pid