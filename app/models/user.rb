class User < ApplicationRecord
  has_many :scenarios
  has_many :participations
  has_many :participated_scenarios, through: :participations, source: :scenario

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :trackable
end
