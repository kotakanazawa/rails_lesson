# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i(github)

  has_one_attached :image
  validates :name, :email, presence: true
  has_many :books, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_follows, class_name: "Follow", foreign_key: :following_id
  has_many :passive_follows, class_name: "Follow", foreign_key: :follower_id
  has_many :followings, through: :active_follows, source: :follower
  has_many :followers, through: :passive_follows, source: :following

  def followed_by?(user)
    passive_follows.find_by(following_id: user.id).present?
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.find_for_github_oauth(auth, signed_in_resource = nil)
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    unless user
      user = User.new(provider: auth.provider,
                      uid:      auth.uid,
                      name:     auth.info.name,
                      email:    User.dummy_email(auth),
                      password: Devise.friendly_token[0, 20]
      )
    end
    user.save
    user
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
