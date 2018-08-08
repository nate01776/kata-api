# Altitude API

Support for the internal demo environment

### dependencies
- ruby
- bundler
- postgres

### install
```
bundle install
bundle update
```
- Verify the /config/database.yaml settings are correct

### start 
```
ruby ./server.rb -o {ip_address}
```

### reset 
```
rake db:migrate:reset
```

nohup ruby ./server.rb -p 4567 -o 10.0.25.247 >> ./logs/log_file.txt 2>&1 &

echo $! > ./logs/server.pid