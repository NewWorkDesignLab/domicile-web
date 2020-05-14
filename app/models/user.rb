class User < ApplicationRecord
  has_many :scenarios # Scenarios this User created
  has_many :participations # Participations of this User
  has_many :participated_scenarios, through: :participations, source: :scenario # Scenarios this User participated
  has_many :hosted_participations, through: :scenarios, source: :participations # Participations in Scenarios this User created
  has_many :executions, through: :participations # Executions this User created
  has_many :hosted_executions, through: :scenarios, source: :executions # Executions in Scenarios this USer created

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :trackable

  include DeviseTokenAuth::Concerns::User

  # Cannot use "participations.or(hosted_participations)" because :hosted_participations uses join
  # in the background, so the scopes doesnt have the same Columns
  def available_participations
    Participation.joins(:scenario).where("participations.user_id = ? OR scenarios.user_id = ?", id, id)
  end

  # Override Devise Method to send Emails via Active Job, as describet in:
  # https://github.com/heartcombo/devise#activejob-integration
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
