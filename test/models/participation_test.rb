require 'test_helper'

class ParticipationTest < ActiveSupport::TestCase
  test 'should work with user(owner) relation' do
    assert my_user = create_user
    assert model = create_participation(user: my_user)
    assert_equal model.user, my_user
  end

  test 'should work with scenario relation' do
    assert my_scenario = create_scenario
    assert model = create_participation(scenario_id: my_scenario[:id])
    assert_equal model.scenario, my_scenario
  end

  test 'should work in relation with many executions and destroy related executions if participation gets destroyed' do
    assert my_participation = create_participation
    assert my_other_participation = create_participation
    assert_equal 2, Participation.count
    assert_equal 0, Execution.count

    assert create_execution(participation_id: my_participation[:id])
    assert_equal 1, my_participation.executions.count
    assert_equal 0, my_other_participation.executions.count
    assert_equal 1, Execution.count

    assert create_execution(participation_id: my_participation[:id])
    assert_equal 2, my_participation.executions.count
    assert_equal 0, my_other_participation.executions.count
    assert_equal 2, Execution.count

    assert create_execution(participation_id: my_participation[:id])
    assert_equal 3, my_participation.executions.count
    assert_equal 0, my_other_participation.executions.count
    assert_equal 3, Execution.count

    assert create_execution(participation_id: my_other_participation[:id])
    assert_equal 3, my_participation.executions.count
    assert_equal 1, my_other_participation.executions.count
    assert_equal 4, Execution.count

    my_participation.destroy
    assert_equal 1, my_other_participation.executions.count
    assert_equal 1, Participation.count
    assert_equal 1, Execution.count
  end
end
