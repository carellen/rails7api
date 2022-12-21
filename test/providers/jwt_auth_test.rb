require 'test_helper'

class JwtAuthTest < ActiveSupport::TestCase
  test 'should login user' do
    user = users(:one)

    assert_difference('user.active_tokens.size', 1) do
      Providers::JwtAuth.login(user: user)
    end
  end

  test 'should authenticate user by token' do
    user = users(:one)
    token = Providers::JwtAuth.login(user: user)[:result]
    user_from_token = Providers::JwtAuth.authenticate(token: token)[:result]

    assert_equal user.id, user_from_token.id
  end

  test 'should logout user' do
    user = users(:one)
    token = Providers::JwtAuth.login(user: user)[:result]
    assert Providers::JwtAuth.authenticate(token: token)[:result].present?

    Providers::JwtAuth.logout(token: token)

    error = Providers::JwtAuth.authenticate(token: token)[:error]

    assert_equal 'User unauthorized', error
  end
end
