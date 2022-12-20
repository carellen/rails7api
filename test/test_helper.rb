ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module JsonHelper
  def json_response
    @json_response ||= JSON.parse(response.body, symbolize_names: true)
  end
end

class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors)

  fixtures :all
end

class ActionDispatch::IntegrationTest
  include JsonHelper
end
