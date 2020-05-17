class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :scenario
  has_many :executions, dependent: :destroy
end
