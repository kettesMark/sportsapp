ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize_me!(workers: :number_of_processors, with: :threads)

  # Add more helper methods to be used by all tests here...
end
