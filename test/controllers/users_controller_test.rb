require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { name: @user.name } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should create user with roles" do
    assert_difference("User.count") do
      post users_url, params: { user: { name: @user.name, role_ids: [roles(:admin).id] } }
    end

    assert User.last.roles.include?(roles(:admin))
  end

  test "should update user" do
    user = users(:admin_editor)
    patch user_url(user), params: { user: { name: @user.name, role_ids: [roles(:editor).id] } }
    assert_redirected_to user_url(user)

    assert user.roles.reload.first == roles(:editor)
  end

  test "should not update user with member roles" do
    user = users(:member)
    patch user_url(user), params: { user: { name: @user.name, role_ids: [roles(:editor).id] } }
    
    assert user.roles.reload.first == roles(:member)

    assert_response(:unprocessable_entity)
  end

end
