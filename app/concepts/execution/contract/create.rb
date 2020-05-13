require "reform"

module Execution::Contract
  class Create < Reform::Form
    property :participation_id,
      validates: {
        presence: true
      }
  end
end
