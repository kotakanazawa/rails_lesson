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
    assert @user1.followed_by?(@user2)
    assert @user2.active_follows.find_by(follower_id: @user1.id).destroy
    assert_not @user1.followed_by?(@user2)
  end
end
