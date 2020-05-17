require 'test_helper'

class ScenarioTest < ActiveSupport::TestCase
  test 'should work with user(owner) relation' do
    assert my_user = create_user
    assert result1 = Scenario::Operation::Create.(params: scenario_params, current_user: my_user)
    assert result1.success?
    assert model = result1[:model]
    assert_equal model.user, my_user
  end

  test 'should work in relation with many participations and destroy related participations if scenario gets destroyed' do
    assert my_scenario = create_scenario
    assert my_other_scenario = create_scenario
    assert_equal 2, Scenario.count
    assert_equal 0, Participation.count
    assert_equal 0, Execution.count

    assert create_participation(scenario_id: my_scenario[:id])
    assert_equal 1, my_scenario.participations.count
    assert_equal 0, my_other_scenario.participations.count
    assert_equal 1, Participation.count

    assert create_participation(scenario_id: my_scenario[:id])
    assert_equal 2, my_scenario.participations.count
    assert_equal 0, my_other_scenario.participations.count
    assert_equal 2, Participation.count

    assert create_participation(scenario_id: my_scenario[:id])
    assert_equal 3, my_scenario.participations.count
    assert_equal 0, my_other_scenario.participations.count
    assert_equal 3, Participation.count

    assert create_participation(scenario_id: my_other_scenario[:id])
    assert_equal 3, my_scenario.participations.count
    assert_equal 1, my_other_scenario.participations.count
    assert_equal 4, Participation.count

    my_scenario.destroy
    assert_equal 1, my_other_scenario.participations.count
    assert_equal 1, Participation.count
    assert_equal 1, Scenario.count
  end

  test 'should work with users and executions relation' do
    assert_equal 0, Scenario.count
    assert_equal 0, Participation.count
    assert_equal 0, Execution.count

    assert my_scenario = create_scenario
    assert user_1 = create_user
    assert user_2 = create_user
    assert user_3 = create_user
    assert_equal 0, my_scenario.users.count

    assert participation_1 = create_participation(scenario_id: my_scenario[:id], user: user_1)
    assert_equal 1, my_scenario.users.count
    assert_equal 0, my_scenario.executions.count
    assert_equal 1, user_1.participations.count
    assert_equal 1, Participation.count

    assert participation_2 = create_participation(scenario_id: my_scenario[:id], user: user_2)
    assert participation_3 = create_participation(scenario_id: my_scenario[:id], user: user_3)
    assert_equal 3, my_scenario.users.count
    assert_equal 0, my_scenario.executions.count
    assert_equal 1, user_1.participations.count
    assert_equal 1, user_2.participations.count
    assert_equal 1, user_3.participations.count
    assert_equal 3, Participation.count

    user_3.destroy
    assert_equal 2, my_scenario.users.count

    assert_equal 0, my_scenario.executions.count
    assert create_execution(participation_id: participation_1[:id])
    assert_equal 1, my_scenario.executions.count
    assert create_execution(participation_id: participation_1[:id])
    assert create_execution(participation_id: participation_2[:id])
    assert_equal 3, my_scenario.executions.count
  end

  test 'should validate password on participation' do
    assert my_scenario = create_scenario # default password in tests: '12345678'

    assert result = Participation::Operation::Create.(params: participation_params(password: '', scenario_id: my_scenario[:id]), current_user: create_user)
    assert result.failure?
    assert_equal 'Passwort nicht korrekt', result['contract.default'].errors.messages[:password].first

    assert result = Participation::Operation::Create.(params: participation_params(password: '1234567', scenario_id: my_scenario[:id]), current_user: create_user)
    assert result.failure?
    assert_equal 'Passwort nicht korrekt', result['contract.default'].errors.messages[:password].first

    assert result = Participation::Operation::Create.(params: participation_params(password: '123456789', scenario_id: my_scenario[:id]), current_user: create_user)
    assert result.failure?
    assert_equal 'Passwort nicht korrekt', result['contract.default'].errors.messages[:password].first
  end
end
