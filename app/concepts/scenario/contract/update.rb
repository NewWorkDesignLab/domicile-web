require "reform"
require "reform/form/validation/unique_validator"

module Scenario::Contract
  class Update < Reform::Form
    property :name,
      validates: {
        presence: false,
        length: {
          maximum: 255,
          allow_blank: true
        }
      }
    property :password,
      validates: {
        presence: false,
        length: {
          minimum: 6,
          maximum: 255,
          allow_blank: true
        }
      }
    property :password_confirmation,
      virtual: true

    validate do
      unless password == password_confirmation
        errors.add(:password, :match)
        errors.add(:password_confirmation, :match)
      end
    end

    private

    def name=(val)
      super(val == "" ? nil : val)
    end
  end
end
