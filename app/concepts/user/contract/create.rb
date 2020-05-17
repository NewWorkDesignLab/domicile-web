require "reform"
require "reform/form/validation/unique_validator"

module User::Contract
  class Create < Reform::Form
    property :email,
      validates: {
        presence: true
      }
    property :password,
      validates: {
        presence: true
      }
    property :password_confirmation,
      validates: {
        presence: true
      }

    validate :passwords_are_equal

    private

    def passwords_are_equal
      if password != password_confirmation
        errors.add(:password_confirmation, I18n.t('errors.messages.password_confirmation'))
      end
    end
  end
end
