require "reform"

module Participation::Contract
  class Create < Reform::Form
    property :user,
      parse: false,
      validates: {
        presence: true
      }
    property :scenario_id,
      validates: {
        presence: true,
        length: {
          minimum: 5,
          maximum: 5,
          allow_blank: false
        },
        format: {
          with: /\A(\d{5})\z/
        }
      }
    property :password,
      virtual: true

    validate do
      if !Scenario.exists?(id: scenario_id)
        errors.add(:scenario_id, I18n.t('activerecord.errors.models.participation.user.model_not_found'))
      end

      if Participation.where(user_id: user[:id]).where(scenario_id: scenario_id).present?
        errors.add(:user, I18n.t('activerecord.errors.models.participation.user.already_participated'))
      end

      if Scenario.exists?(id: scenario_id) && Scenario.find(scenario_id).password_digest.present? && !Scenario.find(scenario_id).authenticate(password)
        errors.add(:password,I18n.t('activerecord.errors.models.participation.user.auth_failed'))
      end
    end
  end
end