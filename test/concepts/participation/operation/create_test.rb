require 'test_helper'

class Participation::Operation::CreateTest < ActiveSupport::TestCase
  test 'should succeed creating participation' do
    assert_difference 'Participation.count' do
      assert result = Participation::Operation::Create.(
        params: participation_params,
        current_user: user
      )
      assert result.success?
      assert result['contract.default'].errors.blank?
      assert model = result[:model]
      assert model[:id].present?
      assert model[:user_id].present?
      assert model[:scenario_id].present?
    end
  end

  test 'should only participate once per user and scenario' do
    my_scenario = create_scenario
    my_user = create_user

    assert_difference 'Participation.count' do
      assert result = Participation::Operation::Create.(params: participation_params(scenario_id: my_scenario[:id]), current_user: my_user)
      assert result.success?
    end

    assert_no_difference 'Participation.count' do
      assert result = Participation::Operation::Create.(params: participation_params(scenario_id: my_scenario[:id]), current_user: my_user)
      assert result.failure?
      assert_equal 'Sie sind diesem Szenario bereits beigetreten', result['contract.default'].errors.messages[:user].first
    end
  end
end
