# README
# hang-in-there-api

- System dependencies

  * Ruby version: 3.2.2
  * Rails version: 7.1.4
  * PostgreSQL: 14.0

- Gemfile updates:

  * gem "jsonapi-serializer"
  * gem "rspec-rails"
  * gem "pry"
  * gem "simplecov"
  * gem 'shoulda-matchers'
  * Run ```bundle install``` after adding to the Gemfile.
  
- Database creation and modifications

  * Create the Database:```rails db:create```
  * Migrate the Database: ```rails db:migrate```
  * Seed the Database: ```rails db:seed```
  * Drop the Database:```rails db:drop```

- How to run the test suite
  * Both the request spec and model spec: ```bundle exec rspec```
  * Model test only: ```bundle exec spec/requests```
  * SimpleCov test coverage: ```open coverage/index.html```
