require "reform"
require "reform/form/validation/unique_validator"

module Scenario::Contract
  class Create < Reform::Form
    property :user,
      parse: false,
      validates: {
        presence: true
      }
    property :id,
      validates: {
        presence: true,
        unique: true,
        length: {
          minimum: 5,
          maximum: 5,
          allow_blank: false
        },
        format: {
          with: /\A(\d{5})\z/
        }
      }
    property :number_rooms,
      validates: {
        presence: true,
        inclusion: {
          in: ['1', '2', '3'],
          allow_blank: false
        }
      }
    property :time_limit,
      validates: {
        presence: true,
        inclusion: {
          in: ['0', '5', '10', '15', '20'],
          allow_blank: false
        }
      }
    property :number_damages,
      validates: {
        presence: true,
        inclusion: {
          in: ['2', '3', '4', '5', '6', '7', '8', '9', '10'],
          allow_blank: false
        }
      }
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
