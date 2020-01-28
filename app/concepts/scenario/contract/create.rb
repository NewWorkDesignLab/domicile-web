require "reform"
require "reform/form/validation/unique_validator"

module Scenario::Contract
  class Create < Reform::Form
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
          with: /\A[0-9]+\z/
        }
      }
    
    property :password,
      validates: {
        presence: true,
        length: {
          minimum: 8,
          maximum: 20,
          allow_blank: false
        }
      }
    
    property :number_rooms,
      default: 3,
      validates: {
        presence: false,
        inclusion: {
          in: ['1', '2', '3'],
          allow_blank: true
        }
      }

    property :time_limit,
      default: 10,
      validates: {
        presence: false,
        inclusion: {
          in: ['5', '10', '15', '20', 'no'],
          allow_blank: true
        }
      }
    
    property :number_damages,
      default: 5,
      validates: {
        presence: false,
        inclusion: {
          in: ['2', '3', '4', '5', '6', '7', '8', '9', '10'],
          allow_blank: true
        }
      }
    
    property :legal,
      validates: {
        presence: true,
        inclusion: {
          in: ['1'],
          allow_blank: false
        }
      }
  end
end