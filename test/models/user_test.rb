# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user1 = users(:user1)
    @user2 = users(:user2)
  end

  test "userが登録できている" do
    assert @user1.valid?
    assert @user2.valid?
  end

  test "followed_byのテストができている" do
    user1 = users(:user1)
    user2  = users(:user2)
    assert_not user2.followed_by?(user1)
    assert user1.followings << user2
    assert user2.followed_by?(user1)
    assert user1.active_follows.find_by(follower_id: user2.id).destroy
    assert_not user2.followed_by?(user1)
  end
end
