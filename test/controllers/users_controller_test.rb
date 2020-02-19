# frozen_string_literal: true

require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  setup do
    Warden.test_mode!
    @user1 = users(:user1)
    login_as(@user1, scope: :user)
  end

  test "should get show" do
    get users_path
    assert_response :success
  end
end
