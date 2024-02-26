require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should save roles" do
    user = User.new(name: "Test")
    user.role_ids = [roles(:admin).id, roles(:member).id]
    assert user.save

    assert user.roles.size == 2
    assert user.roles.include?(roles(:admin))
    assert user.roles.include?(roles(:member))
  end

  test "should update roles" do
    user = users(:admin_editor)
    user.role_ids = [roles(:admin).id, roles(:member).id]
    assert user.save

    assert user.roles.size == 2
    assert user.roles.include?(roles(:admin))
    assert user.roles.include?(roles(:member))
  end

  test "should not update member roles" do
    user = users(:member)
    user.role_ids = [roles(:admin).id]
    assert_not user.save

    p Role.joins(:users)
      # .where(name: member_roles)
      .where(users: { id: user.id })

    assert user.roles.size == 1
    assert user.roles.reload.include?(roles(:member))
  end
end
