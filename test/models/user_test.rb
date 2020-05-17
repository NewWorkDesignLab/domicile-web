require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should work in relation with many scenarios and destroy related scenarios if user gets destroyed' do
    my_user = create_user
    my_other_user = create_user

    create_scenario(user: my_user)
    assert_equal 1, my_user.scenarios.count
    assert_equal 1, Scenario.count

    create_scenario(user: my_user)
    assert_equal 2, my_user.scenarios.count
    assert_equal 2, Scenario.count

    create_scenario(user: my_user)
    assert_equal 3, my_user.scenarios.count
    assert_equal 3, Scenario.count

    create_scenario(user: my_other_user)
    assert_equal 3, my_user.scenarios.count
    assert_equal 1, my_other_user.scenarios.count
    assert_equal 4, Scenario.count

    my_user.destroy
    assert_equal 1, Scenario.count
  end

  test 'should work in relation with many participations and destroy related participations if user gets detroyed' do
    my_user = create_user
    my_other_user = create_user

    create_participation(user: my_user)
    assert_equal 1, my_user.participations.count
    assert_equal 1, Participation.count

    create_participation(user: my_user)
    assert_equal 2, my_user.participations.count
    assert_equal 2, Participation.count

    create_participation(user: my_user)
    assert_equal 3, my_user.participations.count

    create_participation(user: my_other_user)
    assert_equal 3, my_user.participations.count
    assert_equal 1, my_other_user.participations.count
    assert_equal 4, Participation.count

    my_user.destroy
    assert_equal 1, Participation.count
  end

  test 'should work with scenario scopes in both directions' do
    my_user = create_user
    scenario_owner = create_user

    assert scenario1 = create_scenario(user: scenario_owner)
    assert_equal 0, my_user.scenarios.count
    assert_equal 0, my_user.participated_scenarios.count
    assert_equal 1, scenario_owner.scenarios.count
    assert_equal 0, scenario_owner.participated_scenarios.count

    create_participation(scenario_id: scenario1[:id], user: my_user)
    assert_equal 0, my_user.scenarios.count
    assert_equal 1, my_user.participated_scenarios.count
    assert_equal 1, scenario_owner.scenarios.count
    assert_equal 0, scenario_owner.participated_scenarios.count

    assert_equal scenario_owner.scenarios.first, my_user.participated_scenarios.first
    assert_equal my_user.participated_scenarios.first, my_user.participations.first.scenario
  end

  test 'should work with participation scopes in both directions' do
    my_user = create_user
    scenario_owner = create_user
    my_scenario = create_scenario(user: scenario_owner)

    assert_equal 0, my_user.participations.count
    assert_equal 0, my_user.hosted_participations.count
    assert_equal 0, scenario_owner.participations.count
    assert_equal 0, scenario_owner.hosted_participations.count

    create_participation(scenario_id: my_scenario[:id], user: my_user)
    assert_equal 1, my_user.participations.count
    assert_equal 0, my_user.hosted_participations.count
    assert_equal 0, scenario_owner.participations.count
    assert_equal 1, scenario_owner.hosted_participations.count

    assert_equal scenario_owner.hosted_participations.first, my_user.participations.first
    assert_equal scenario_owner.hosted_participations.first, scenario_owner.scenarios.first.participations.first
  end

  test 'should work with execution scopes in both directions' do
    my_user = create_user
    scenario_owner = create_user
    my_scenario = create_scenario(user: scenario_owner)

    assert_equal 0, my_user.executions.count
    assert_equal 0, my_user.hosted_executions.count
    assert_equal 0, scenario_owner.executions.count
    assert_equal 0, scenario_owner.hosted_executions.count

    my_participation = create_participation(scenario_id: my_scenario[:id], user: my_user)
    my_execution = create_execution(participation_id: my_participation[:id], user: my_user)
    assert_equal 1, my_user.executions.count
    assert_equal 0, my_user.hosted_executions.count
    assert_equal 0, scenario_owner.executions.count
    assert_equal 1, scenario_owner.hosted_executions.count

    assert_equal my_user.executions.first, scenario_owner.hosted_executions.first
    assert_equal scenario_owner.hosted_executions.first, scenario_owner.scenarios.first.executions.first
    assert_equal scenario_owner.hosted_executions.first, scenario_owner.scenarios.first.participations.first.executions.first
  end

  test 'should work with available_participations scope' do
    my_user = create_user
    my_scenario = create_scenario(user: my_user)

    create_participation(scenario_id: my_scenario[:id], user: my_user)
    create_participation(scenario_id: my_scenario[:id])
    create_participation(user: my_user)

    assert_equal 2, my_user.participations.count
    assert_equal 2, my_user.hosted_participations.count
    assert_equal 3, my_user.available_participations.count
  end
end
