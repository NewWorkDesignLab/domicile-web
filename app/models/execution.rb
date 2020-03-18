class Execution < ApplicationRecord
  belongs_to :participation
  has_many_attached :images
end
