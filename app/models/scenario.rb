class Scenario < ApplicationRecord
  belongs_to :user
  # class_name: '::Participation' added due to a bug: https://github.com/rails/rails/issues/15811
  has_many :participations, class_name: '::Participation', dependent: :destroy
  has_many :users, through: :participations
  has_many :executions, through: :participations

  has_secure_password validations: false
end
