task :settings do
  ENV["RAILS_ENV"] ||= 'development'
  require 'config'
  require_relative '../config/initializers/config'
end
