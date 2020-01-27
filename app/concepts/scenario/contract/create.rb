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
          allow_blank: false,
          message: "Muss im Format '12345' sein."
        },
        format: {
          with: /\A[0-9]+\z/,
          message: "Muss im Format '12345' sein."
        }
      }
    
    property :password,
      validates: {
        presence: true,
        length: {
          minimum: 8,
          maximum: 20,
          allow_blank: false,
          message: "Muss zwischen 8 und 20 Zeichen lang sein."
        }
      }
    
      property :number_rooms,
        default: 3,
        validates: {
          presence: false,
          inclusion: {
            in: [1, 2, 3],
            allow_blank: true,
            message: "Erlaubte Werte: 1, 2, 3"
          }
        }

      property :time_limit,
        default: 10,
        validates: {
          presence: false,
          inclusion: {
            in: [5, 10, 15, 20, 'no'],
            allow_blank: true,
            message: "Erlaubte Werte: 5, 10, 15, 20, no"
          }
        }
      
      property :number_damages,
        default: 5,
        validates: {
          presence: false,
          inclusion: {
            in: [2, 3, 4, 5, 6, 7, 8, 9, 10],
            allow_blank: true,
            message: "Erlaubte Werte: 2, 3, 4, 5, 6, 7, 8, 9, 10"
          }
        }
  end
end