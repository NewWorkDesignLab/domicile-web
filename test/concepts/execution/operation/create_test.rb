require 'test_helper'

class Execution::Operation::CreateTest < ActiveSupport::TestCase
  setup do
    result = Scenario::Operation::Create.(
      params: scenario_params(password: '', password_confirmation: ''),
      current_user: users(:info)
    )
    @scenario = result[:model]

    result = Participation::Operation::Create.(
      params: {participation: {scenario_id: @scenario[:id]} },
      current_user: users(:info)
    )
    @participation = result[:model]
  end

  test 'should succeed creating execution' do
    assert_difference 'Execution.count' do
      assert result = Execution::Operation::Create.(
        params: { execution: {participation_id: @participation[:id]} }
      )
      assert result.success?
      assert result['contract.default'].errors.blank?
      assert model = result[:model]
      assert model[:id].present?
      assert model[:participation_id].present?

      assert_equal @participation, model.participation
      assert_equal @scenario, model.scenario
    end
  end
end
