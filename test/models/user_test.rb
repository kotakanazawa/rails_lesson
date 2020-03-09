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

  test "ユーザーをフォロー、アンフォローができる" do
    user1 = users(:user1)
    user2  = users(:user2)
    assert_not user2.followed_by?(user1)
    user1.follow(user2)
    assert user2.followed_by?(user1)
    user1.unfollow(user2)
    assert_not user2.followed_by?(user1)
  end
end
