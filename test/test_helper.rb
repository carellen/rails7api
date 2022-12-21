ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module JsonHelper
  def json_response
    @json_response ||= JSON.parse(response.body, symbolize_names: true)
  end
end

module JwtLoginHelper
  def auth_header_for(user)
    token = Providers::JwtAuth.login(user: user)[:result]

    { 'Authorization' => "Bearer #{token}" }
  end
end

class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors)

  fixtures :all
end

class ActionDispatch::IntegrationTest
  include JsonHelper
  include JwtLoginHelper
end
