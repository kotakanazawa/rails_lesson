# frozen_string_literal: true

require "test_helper"

class BookTest < ActiveSupport::TestCase
  setup do
    @book1 = books(:book1)
  end

  test "book1が登録できている" do
    assert @book1.valid?
  end
end
