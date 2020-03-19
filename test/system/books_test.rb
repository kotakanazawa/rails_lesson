# frozen_string_literal: true

require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  def setup
    Warden.test_mode!
    @user1 = users(:user1)
    login_as(@user1)
  end

  test "show books" do
    visit root_path

    assert_selector "h1", text: I18n.t("title.books")
  end

  test "create book" do
    visit new_book_path

    fill_in I18n.t("activerecord.attributes.book.title"), with: "メモの魔力"
    fill_in I18n.t("activerecord.attributes.book.memo"), with: "いろいろ学べた"
    fill_in I18n.t("activerecord.attributes.book.author"), with: "前田裕二"
    attach_file I18n.t("activerecord.attributes.book.image"), Rails.root.join("test/fixtures/images/books/book1.png")

    assert_difference "Book.count", 1 do
      click_button I18n.t("helpers.submit.create")
    end

    assert_text I18n.t("success.book_was_successfully_created")
  end

  test "show book" do
    book = books(:book1)
    visit book_path(book)

    assert_selector "h1", text: I18n.t("title.book")
  end

  test "update book" do
    book = books(:book1)
    visit edit_book_path(book)

    fill_in I18n.t("activerecord.attributes.book.title"), with: "独学のすすめ"
    fill_in I18n.t("activerecord.attributes.book.memo"), with: "すばらしくわかりやすい"
    fill_in I18n.t("activerecord.attributes.book.author"), with: "加藤秀俊"
    find('input[type="submit"]').click

    assert_text I18n.t("success.book_was_successfully_updated")
  end

  test "destroy book" do
    visit root_path

    page.accept_confirm do
      click_on I18n.t("link.destroy"), match: :first
    end

    assert_text I18n.t("success.book_was_successfully_destroyed")
  end
end
