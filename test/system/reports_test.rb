# frozen_string_literal: true

require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    Warden.test_mode!
    @user1 = users(:user1)
    login_as(@user1)
    @report = reports(:report)
  end

  test "show reports" do
    visit user_path(@user1)

    assert_selector "h2", text: "日報"
  end

  test "create report" do
    visit new_report_path

    fill_in I18n.t("activerecord.attributes.report.title"), with: "システムテストを作った"
    fill_in I18n.t("activerecord.attributes.report.body"), with: "たのしかった"

    assert_difference "Report.count", 1 do
      click_button I18n.t("helpers.submit.create")
    end

    assert_text I18n.t("success.report_was_successfully_created")
  end

  test "show report" do
    visit report_path(@report)

    assert_selector "h1", text: I18n.t("title.report")
  end

  test "update report" do
    visit edit_report_path(@report)

    fill_in I18n.t("activerecord.attributes.report.title"), with: "システムテストのやり直し"
    fill_in I18n.t("activerecord.attributes.report.body"), with: "レポートテストの修正"
    click_button I18n.t("helpers.submit.update")

    assert_text I18n.t("success.report_was_successfully_updated")
  end

  test "destroy report" do
    visit user_path(@user1)

    page.accept_confirm do
      click_on I18n.t("link.destroy"), match: :first
    end

    assert_text I18n.t("success.report_was_successfully_destroyed")
  end
end
