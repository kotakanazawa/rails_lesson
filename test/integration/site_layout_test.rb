# frozen_string_literal: true

require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    Warden.test_mode!
    @user1 = users(:user1)
    login_as(@user1)
    @book1 = books(:book1)
  end

  test "layout links" do
    get root_path
    assert_template "books/index"
    assert_select "a[href=?]", user_path(@user1)
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", edit_user_registration_path
    assert_select "a[href=?]", destroy_user_session_path
    assert @user1.name.present?
    assert_select "a[href=?]", book_path(@book1), count: 2
    assert_select "a[href=?]", edit_book_path(@book1)
    assert_select "a[href=?]", new_book_path
  end
end
