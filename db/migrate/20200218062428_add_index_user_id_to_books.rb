# frozen_string_literal: true

class AddIndexUserIdToBooks < ActiveRecord::Migration[6.0]
  def change
    add_index :books, :user_id
  end
end
