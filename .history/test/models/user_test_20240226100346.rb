require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should save roles" do
    user = User.new(name: "Test")
    user.role_ids = [user(:admin).id, user(:member).id]
    assert user.save

    assert user.roles.size == 2
    assert user.roles.include?(user(:admin))
    assert user.roles.include?(user(:member))
  end
end
