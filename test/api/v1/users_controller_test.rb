class UsersControllerTest < ApiBaseTest
  test 'should return users list' do
    get api_users_path

    users_from_response =  json_response[:users].map { |user| user[:id] }.sort
    users_from_db = users.map { |user| user[:id] }.sort

    assert_equal users_from_response, users_from_db
  end

  test 'should return user' do
    user_id = users(:one).id

    get api_user_path(user_id)

    user_from_response = json_response[:user]

    assert_equal user_from_response[:id], user_id
  end

  test 'should create user' do
    user_params = { email: 'next@user.com', password: 'test', password_confirmation: 'test' }

    assert_difference('User.count', 1) do
      post api_users_path, params: user_params
    end

    new_user = json_response[:user]

    assert_equal new_user[:email], user_params[:email]
  end

  test 'should update user' do
    user = users(:one)
    user_params = { email: 'updated@user.com' }

    assert_changes('user.reload.email', from: user.email, to: user_params[:email]) do
      patch api_user_path(user.id), params: user_params
    end
  end

  test 'should delete user' do
    assert_difference('User.count', -1) do
      delete api_user_path(users(:one).id)
    end
  end
end
