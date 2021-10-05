ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
require 'sinatra'
require 'rake'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
Bundler.require(:default, ENV['RACK_ENV'])

# require 'fast_jsonapi'
# require 'kaminari'
# require 'dry-initializer'
# require 'factory_bot'

Dir['./config/initializers/*.rb'].sort.each { |file| require file }
Dir['./app/models/concerns/*.rb'].sort.each { |file| require file }
Dir['./app/models/*.rb'].sort.each { |file| require file }
Dir['./app/contracts/*.rb'].sort.each { |file| require file }
Dir['./app/concerns/*.rb'].sort.each { |file| require file }
Dir['./app/serializers/*.rb'].sort.each { |file| require file }
Dir['./app/services/*.rb'].sort.each { |file| require file }
Dir['./app/services/**/*.rb'].sort.each { |file| require file }
Dir['./app/lib/**/*.rb'].sort.each { |file| require file }

require './app/application'
