class ListsControllerTest < ApiBaseTest
  setup do
    @user = users(:one)
  end

  test 'anonymous user should see public user`s TODO lists only' do
    get api_lists_path

    lists_from_response = json_response[:lists]

    assert_equal List.shared.size, lists_from_response.size
  end

  test 'logged user should see all it`s TODO lists' do
    get api_users_lists_path, headers: auth_header_for(@user)

    lists_from_response = json_response[:user_lists]

    assert_equal @user.lists.size, lists_from_response.size
  end

  test 'should create list' do
    list_params = { name: 'next list' }

    assert_difference('@user.lists.size', 1) do
      post api_users_lists_path, params: list_params, headers: auth_header_for(@user)
    end
  end

  test 'should update list' do
    list = @user.lists.first
    list_params = { name: 'updated name' }

    assert_changes('list.reload.name', from: list.name, to: 'updated name') do
      patch api_users_list_path(list.id), params: list_params, headers: auth_header_for(@user)
    end
  end

  test 'should delete list' do
    list = @user.lists.first

    assert_difference('@user.lists.size', -1) do
      delete api_users_list_path(list.id), headers: auth_header_for(@user)
    end
  end

  test 'should not process unauthorized action' do
    list = @user.lists.first
    current_user = users(:two)

    assert_no_difference('@user.lists.size', -1) do
      delete api_users_list_path(list.id), headers: auth_header_for(current_user)
    end
  end
end
