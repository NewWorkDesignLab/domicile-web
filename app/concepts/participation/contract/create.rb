require "reform"
require "reform/form/validation/unique_validator"

module Participation::Contract
  class Create < Reform::Form
    property :user_id,
      parse: false,
      validates: {
        presence: true
      }
    property :scenario_id,
      parse: false,
      validates: {
        presence: true
      }
    property :password, virtual: true
  end
end