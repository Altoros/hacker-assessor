if ENV['CODECLIMATE_REPO_TOKEN'] &&
   ENV['CI_BRANCH'] == 'master'
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

# be logged by default
ActionController::TestCase.setup do
  session[:hacker_id] = hackers(:admin).id
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  setup do
    Capybara.reset_sessions!
  end
end
