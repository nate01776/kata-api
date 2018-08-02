require './support/database_cleaner.rb'

RSpec.configure do |config|
    config.include FactoryBot::Syntax::Methods
    config.use_transactional_fixtures = false
  
    config.before(:suite) do
      FactoryBot.find_definitions
    end
  end