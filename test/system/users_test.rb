# frozen_string_literal: true

require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    Warden.test_mode!
    @user1 = users(:user1)
    login_as(@user1)
  end

  test "show users" do
    visit users_path

    assert_selector "h1", text: "ユーザー一覧"
  end

  test "create account" do
    logout
    visit new_user_registration_path

    fill_in I18n.t("activerecord.attributes.user.name"), with: "Kota Kanazawa"
    fill_in I18n.t("activerecord.attributes.user.email"), with: "kota@example.com"
    fill_in I18n.t("activerecord.attributes.user.postcode"), with: "0000000"
    fill_in I18n.t("activerecord.attributes.user.address"), with: "日本"
    fill_in I18n.t("activerecord.attributes.user.password"), with: "password"
    fill_in I18n.t("activerecord.attributes.user.password_confirmation"), with: "password"

    attach_file I18n.t("activerecord.attributes.user.image"), "#{Rails.root.join('test/fixtures/images/users/user1.jpeg')}"


    assert_difference "User.count", 1 do
      click_button I18n.t("devise.registrations.new.sign_up")
    end

    assert_text I18n.t("devise.registrations.signed_up")
  end

  test "show user page" do
    visit user_path(@user1)

    assert_selector "h2", text: "プロフィール"
  end

  test "edit account" do
    visit edit_user_registration_path(@user1)

    fill_in I18n.t("activerecord.attributes.user.name"), with: "Jason Tatum"
    fill_in I18n.t("activerecord.attributes.user.email"), with: "jason@example.com"
    fill_in I18n.t("activerecord.attributes.user.postcode"), with: "0000000"
    fill_in I18n.t("activerecord.attributes.user.address"), with: "USA"
    attach_file I18n.t("activerecord.attributes.user.image"), "#{Rails.root.join('test/fixtures/images/users/user2.jpeg')}"
    fill_in I18n.t("activerecord.attributes.user.address"), with: "USA"
    fill_in I18n.t("activerecord.attributes.user.current_password"), with: "password"

    click_button I18n.t("devise.registrations.edit.update")

    assert_text I18n.t("devise.registrations.updated")
  end

  test "delete account" do
    visit edit_user_registration_path(@user1)

    page.accept_confirm do
      click_button I18n.t("devise.registrations.edit.cancel_my_account")
    end
  end
end
