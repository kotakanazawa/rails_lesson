# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user1 = users(:user1)
  end

  test "user1が登録できている" do
    assert @user1.valid?
  end
end
