require "reform"

module Participation::Contract
  class Update < Reform::Form
    property :role,
      validates: {
        presence: false,
        inclusion: {
          in: ['player', 'spectator'],
          allow_blank: true
        }
      }
  end
end
