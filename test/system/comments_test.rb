# frozen_string_literal: true

require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  def setup
    Warden.test_mode!
    @user1 = users(:user1)
    login_as(@user1)
    @book = books(:book1)
    @report = reports(:report)
  end

  test "show comments on book page" do
    visit book_path(@book)

    assert_selector "h2", text: I18n.t("title.comments")
  end

  test "show comments on report page" do
    visit report_path(@report)

    assert_selector "h2", text: I18n.t("title.comments")
  end

  test "create comment on book page" do
    visit new_book_comment_path(@book)

    fill_in I18n.t("activerecord.attributes.comment.body"), with: "ええやん"
    click_button I18n.t("helpers.submit.create")

    assert_text I18n.t("success.comment_was_successfully_created")
  end

  test "create comment on report page" do
    visit new_report_comment_path(@report)

    fill_in I18n.t("activerecord.attributes.comment.body"), with: "ええやん"
    click_button I18n.t("helpers.submit.create")

    assert_text I18n.t("success.comment_was_successfully_created")
  end

  test "delete comment on book page" do
    visit book_path(@book)

    page.accept_confirm do
      click_on I18n.t("link.destroy"), match: :first
    end

    assert_text I18n.t("success.comment_was_successfully_destroyed")
  end

  test "delete comment on report page" do
    visit report_path(@report)

    page.accept_confirm do
      click_on I18n.t("link.destroy"), match: :first
    end

    assert_text I18n.t("success.comment_was_successfully_destroyed")
  end
end
