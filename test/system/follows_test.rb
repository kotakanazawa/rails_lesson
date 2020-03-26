# frozen_string_literal: true

require "application_system_test_case"

class FollowsTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    Warden.test_mode!
    @user1 = users(:user1)
    login_as(@user1)
  end

  test "show followings" do
    visit follows_user_path(@user1)

    assert_selector "h1", text: "フォローの中ユーザー"
  end

  test "show followers" do
    visit followers_user_path(@user1)

    assert_selector "h1", text: "フォロワー"
  end

  test "follow user" do
    visit users_path

    assert_difference "Follow.count", 1 do
      click_link "フォローする"
    end
  end

  test "unfollow user" do
    visit users_path

    assert_difference "Follow.count", -1 do
      click_link "フォロー解除"
    end
  end
end
