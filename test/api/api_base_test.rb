require 'test_helper'

class ApiBaseTest < ActionDispatch::IntegrationTest
  setup do
    host! 'api.example.com'
  end
end
