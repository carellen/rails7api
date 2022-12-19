class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'should process unmatched with not_found' do
    get '/non/existing/path'
    assert_response :not_found
  end
end
