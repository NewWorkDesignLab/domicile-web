class User < ApplicationRecord
  has_many :scenarios # Scenarios this User created
  has_many :participated_scenarios, through: :participations, source: :scenario # Scenarios this User participated
  has_many :participations # Participations of this User
  has_many :hosted_participations, through: :scenarios, source: :participations # Participations in Scenarios this User created
  has_many :executions, through: :participations # Executions this User created

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :trackable

  def available_participations
    Participation.joins(:scenario).where("participations.user_id = ? OR scenarios.user_id = ?", id, id)
  end
end
