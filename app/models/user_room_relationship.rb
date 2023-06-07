# frozen_string_literal: true

class UserRoomRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :room
end
