# frozen_string_literal: true

class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
end
