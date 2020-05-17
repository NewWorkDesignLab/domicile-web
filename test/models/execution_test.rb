require 'test_helper'

class ExecutionTest < ActiveSupport::TestCase
  test 'should work with user, scenario and participation relations' do
    assert my_user = create_user
    assert my_scenario = create_scenario(user: my_user)
    assert my_participation = create_participation(scenario_id: my_scenario[:id], user: my_user)
    assert my_execution = create_execution(participation_id: my_participation[:id])

    assert_equal my_execution.participation, my_participation
    assert_equal my_execution.user, my_user
    assert_equal my_execution.scenario, my_scenario
  end

  test 'should attach images and destroy on execution destroy' do
    assert my_execution = create_execution
    assert my_other_execution = create_execution

    assert_equal 0, ActiveStorage::Attachment.count
    assert_equal 0, my_execution.images.count
    assert_equal 0, my_other_execution.images.count

    my_execution.images.attach(png_test_file)
    assert_equal 1, ActiveStorage::Attachment.count
    assert_equal 1, my_execution.images.count
    assert_equal 0, my_other_execution.images.count

    my_execution.images.attach(png_test_file)
    my_execution.images.attach(png_test_file)
    my_execution.images.attach(png_test_file)
    assert_equal 4, ActiveStorage::Attachment.count
    assert_equal 4, my_execution.images.count
    assert_equal 0, my_other_execution.images.count

    my_other_execution.images.attach(png_test_file)
    assert_equal 5, ActiveStorage::Attachment.count
    assert_equal 4, my_execution.images.count
    assert_equal 1, my_other_execution.images.count

    my_execution.destroy
    assert_equal 1, ActiveStorage::Attachment.count
    assert_equal 1, my_other_execution.images.count
  end
end
