require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should save roles" do
    user = User.new(name: "Test")
    user.role_ids = [users(:admin).id, users(:member).id]
    assert user.save

    assert user.roles.size == 2
    assert user.roles.include?(users(:admin))
    assert user.roles.include?(users(:member))
  end
end
