require 'test_helper'

class Execution::Operation::CreateTest < ActiveSupport::TestCase
  test 'should succeed creating execution' do
    assert_difference 'Execution.count' do
      assert result = Execution::Operation::Create.(
        params: execution_params
      )
      assert result.success?
      assert result['contract.default'].errors.blank?
      assert model = result[:model]
      assert model[:id].present?
      assert model[:participation_id].present?
    end
  end
end
