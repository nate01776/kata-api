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

### start 
```
ruby ./server.rb -o {ip_address}
```

### reset 
```
rake db:migrate:reset
```