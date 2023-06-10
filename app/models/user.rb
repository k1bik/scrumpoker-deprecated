# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: [:google_oauth2]
  has_one :room
  has_one_attached :avatar
  has_many :user_room_relationships
  has_many :rooms, through: :user_room_relationships

  scope :not_hidden, -> { includes(:user_room_relationships).where(user_room_relationships: { hidden: false }) }
  scope :hidden, -> { includes(:user_room_relationships).where(user_room_relationships: { hidden: true }) }
  scope :sorted_by_estimate,
        lambda {
          joins(:user_room_relationships).order(Arel.sql('CAST(user_room_relationships.estimate AS INT) asc'))
        }

  def room_estimate(room_id)
    user_room_relationships.find_by(room_id:).estimate
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
    end
  end
end
