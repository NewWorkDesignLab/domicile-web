require 'test_helper'

class Scenario::Operation::CreateTest < ActiveSupport::TestCase
  test 'should succeed creating scenario with key' do
    assert_difference 'Scenario.count' do
      assert result = Scenario::Operation::Create.(params: scenario_params, current_user: users(:info))

      assert result.success?
      assert result['contract.default'].errors.blank?
      assert model = result[:model]
      assert model[:id].present?
      assert model[:user_id].present?
      assert model[:name].present?
      assert model[:password_digest].present?
      assert model[:number_rooms].present?
      assert model[:time_limit].present?
      assert model[:number_damages].present?
    end
  end

  test 'should succeed creating scenario without key' do
    assert_difference 'Scenario.count' do
      assert result = Scenario::Operation::Create.(params: scenario_params(password: '', password_confirmation: ''), current_user: users(:info))

      assert result.success?
      assert result['contract.default'].errors.blank?
      assert model = result[:model]
      assert model[:id].present?
      assert model[:user_id].present?
      assert model[:name].present?
      assert model[:number_rooms].present?
      assert model[:time_limit].present?
      assert model[:number_damages].present?
      assert_nil model[:password_digest]
    end
  end
end
