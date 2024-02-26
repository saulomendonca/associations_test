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
    user = users(:admin_member)
    user.role_ids = [roles(:admin).id, roles(:member).id]
    assert user.save

    assert user.roles.size == 2
    assert user.roles.include?(roles(:admin))
    assert user.roles.include?(roles(:member))
  end
end
