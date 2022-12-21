class ListItemsControllerTest < ApiBaseTest
  setup do
    @user = users(:one)
    @list = @user.lists.first
  end

  test 'should create list item' do
    list_item_params = { short_name: 'next list item' }

    assert_difference('@list.list_items.size', 1) do
      post api_users_list_list_items_path(@list.id), params: list_item_params, headers: auth_header_for(@user)
    end
  end

  test 'should update list item' do
    list_item = @list.list_items.first
    list_item_params = { short_name: 'updated name' }

    assert_changes('list_item.reload.short_name', from: list_item.short_name, to: 'updated name') do
      patch api_users_list_list_item_path(@list.id, list_item.id), params: list_item_params, headers: auth_header_for(@user)
    end
  end

  test 'should delete list item' do
    list_item = @list.list_items.first

    assert_difference('@list.list_items.size', -1) do
      delete api_users_list_list_item_path(@list.id, list_item.id), headers: auth_header_for(@user)
    end
  end

  test 'should not process unauthorized action' do
    list_item = @list.list_items.first
    current_user = users(:two)

    assert_no_difference('@list.list_items.size', -1) do
      delete api_users_list_list_item_path(@list.id, list_item.id), headers: auth_header_for(current_user)
    end
  end
end
