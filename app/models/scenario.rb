class Scenario < ApplicationRecord
  belongs_to :user
  has_many :participations
  has_many :users, through: :participations

  has_secure_password validations: false
end
