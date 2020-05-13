require 'test_helper'

class Participation::Operation::CreateTest < ActiveSupport::TestCase
  setup do
    result = Scenario::Operation::Create.(
      params: scenario_params(password: '', password_confirmation: ''),
      current_user: users(:info)
    )
    @scenario = result[:model]
  end

  test 'should succeed creating participation' do
    assert_difference 'Participation.count' do
      assert result = Participation::Operation::Create.(
        params: {participation: {scenario_id: @scenario[:id]}},
        current_user: users(:info)
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
    assert_difference 'Participation.count' do
      assert result = Participation::Operation::Create.(params: {participation: {scenario_id: @scenario[:id]} }, current_user: users(:info))
      assert result.success?
    end

    assert_no_difference 'Participation.count' do
      assert result = Participation::Operation::Create.(params: {participation: {scenario_id: @scenario[:id]} }, current_user: users(:info))
      assert result.failure?
    end
  end
end
