class LoginControllerTest < ApiBaseTest
  test 'should login user' do
    user = users(:one)

    assert_difference('user.reload.active_tokens.size', 1) do
      post api_login_path, params: { email: user.email, password: 'secret'}
    end
  end

  test 'should logout user' do
    user = users(:one)
    auth_header = auth_header_for(user)

    assert_difference('user.reload.active_tokens.size', -1) do
      delete api_login_path, headers: auth_header
    end
  end
end
