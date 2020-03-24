class Execution < ApplicationRecord
  belongs_to :participation
  has_one :user, through: :participation
  has_one :scenario, through: :participation
  has_many_attached :images
end
