class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User

  has_many :scenarios, dependent: :destroy # Scenarios this User created
  has_many :participations, dependent: :destroy # Participations of this User
  has_many :executions, through: :participations # Executions this User created

  has_many :scenarios_through_participations, through: :participations, source: :scenario # Scenarios this User participated
  has_many :participations_through_scenarios, through: :scenarios, source: :participations # Participations in Scenarios this User created
  has_many :executions_through_scenarios, through: :scenarios, source: :executions # Executions in Scenarios this User created

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :trackable

  # scope :available_participations, -> { where(id: User.participations).or( where(id: User.participations_through_scenarios) ) }

  def hosted_and_joined_scenarios
    Scenario.where( id: scenarios ).or( Scenario.where( id: scenarios_through_participations ) )
  end

  def joined_scenarios_only
    Scenario.where( id: scenarios_through_participations ).where.not( id: scenarios )
  end

  def hosted_scenarios_only
    scenarios
  end

  # Cannot use "participations.or(participations_through_scenarios)" because :participations_through_scenarios uses join
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
