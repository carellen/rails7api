class ConstraintsApiTest < ActiveSupport::TestCase

  setup do
    @request = ::ActionDispatch::TestRequest.create
  end

  test "should match the version from the 'Accept' header" do
    constraint_v1 = Constraints::Api.new(version: 1)
    @request.headers['Accept'] = 'application/vnd.app.v1'

    assert constraint_v1.matches?(@request)
  end

  test "should match the default version when 'default' option is specified" do
    constraint_v2 = Constraints::Api.new(version: 2, default: true)

    assert constraint_v2.matches?(@request)
  end
end
