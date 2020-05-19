ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'faker'
require 'test_data'
require 'test_files'

class ActiveSupport::TestCase
  include TestData
  include TestFiles
  include ActiveJob::TestHelper

  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
  Faker::Config.locale = :en

  def assert_email_send(count: 1)
    assert_difference 'ActionMailer::Base.deliveries.size', count do
      perform_enqueued_jobs do
        yield
      end
    end
  end

  def assert_no_email_send
    assert_no_difference 'ActionMailer::Base.deliveries.size' do
      perform_enqueued_jobs do
        yield
      end
    end
  end
end
