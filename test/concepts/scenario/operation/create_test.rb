require 'test_helper'

class Scenario::Operation::CreateTest < ActiveSupport::TestCase
  test 'should succeed creating scenario with key' do
    assert_difference 'Scenario.count' do
      assert result = Scenario::Operation::Create.(
        params: scenario_params,
        current_user: users(:info)
      )
      assert result.success?
      assert result['contract.default'].errors.blank?
      assert model = result[:model]
      assert model[:id].present?
      assert_match /\A(\d{5})\z/, model[:id].to_s
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
      assert result = Scenario::Operation::Create.(
        params: scenario_params(
          password: '',
          password_confirmation: ''
        ),
        current_user: users(:info)
      )
      assert result.success?
      assert result['contract.default'].errors.blank?
      assert model = result[:model]
      assert model[:id].present?
      assert_match /\A(\d{5})\z/, model[:id].to_s
      assert model[:user_id].present?
      assert model[:name].present?
      assert model[:number_rooms].present?
      assert model[:time_limit].present?
      assert model[:number_damages].present?
      assert_nil model[:password_digest]
    end
  end

  test 'should succeed creating scenario without key and name' do
    assert_difference 'Scenario.count' do
      assert result = Scenario::Operation::Create.(
        params: scenario_params(
          password: '',
          password_confirmation: '',
          name: ''
        ),
        current_user: users(:info)
      )
      assert result.success?
      assert result['contract.default'].errors.blank?
      assert model = result[:model]
      assert model[:id].present?
      assert_match /\A(\d{5})\z/, model[:id].to_s
      assert model[:user_id].present?
      assert model[:number_rooms].present?
      assert model[:time_limit].present?
      assert model[:number_damages].present?
      assert_nil model[:name]
      assert_nil model[:password_digest]
    end
  end

  test 'should fail creating scenario because required value not given' do
    assert_no_difference 'Scenario.count' do
      assert result = Scenario::Operation::Create.(
        params: scenario_params(
          number_rooms: '',
          time_limit: '',
          number_damages: ''
        ),
        current_user: users(:info)
      )
      assert result.failure?
      assert result['contract.default'].errors.present?
      assert_equal 'muss ausgefüllt werden', result['contract.default'].errors.messages[:number_rooms].first
      assert_equal 'muss ausgefüllt werden', result['contract.default'].errors.messages[:time_limit].first
      assert_equal 'muss ausgefüllt werden', result['contract.default'].errors.messages[:number_damages].first
    end
  end

  test 'should fail creating scenario because required value nil' do
    assert_no_difference 'Scenario.count' do
      assert result = Scenario::Operation::Create.(
        params: scenario_params(
          number_rooms: nil,
          time_limit: nil,
          number_damages: nil
        ),
        current_user: users(:info)
      )
      assert result.failure?
      assert result['contract.default'].errors.present?
      assert_equal 'muss ausgefüllt werden', result['contract.default'].errors.messages[:number_rooms].first
      assert_equal 'muss ausgefüllt werden', result['contract.default'].errors.messages[:time_limit].first
      assert_equal 'muss ausgefüllt werden', result['contract.default'].errors.messages[:number_damages].first
    end
  end

  test 'should fail creating scenario because invalid values' do
    assert_no_difference 'Scenario.count' do
      assert result = Scenario::Operation::Create.(
        params: scenario_params(
          number_rooms: '0',
          time_limit: 'wort',
          number_damages: 'false',
          password: '1234',
          password_confirmation: '12345'
        ),
        current_user: users(:info)
      )
      assert result.failure?
      assert result['contract.default'].errors.present?
      assert_equal 'ist kein gültiger Wert', result['contract.default'].errors.messages[:number_rooms].first
      assert_equal 'ist kein gültiger Wert', result['contract.default'].errors.messages[:time_limit].first
      assert_equal 'ist kein gültiger Wert', result['contract.default'].errors.messages[:number_damages].first
      assert_equal 'ist zu kurz (weniger als 6 Zeichen)', result['contract.default'].errors.messages[:password].first
      assert_equal 'Müssen übereinstimmen', result['contract.default'].errors.messages[:password_confirmation].first
    end
  end
end
