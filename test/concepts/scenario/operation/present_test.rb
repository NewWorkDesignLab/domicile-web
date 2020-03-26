require 'test_helper'

class Scenario::Operation::PresentTest < ActiveSupport::TestCase
  test 'should present scenario' do
    assert_no_difference 'Scenario.count' do
      params = {}
      assert result = Scenario::Operation::Present.(params: params)
      assert result.success?
      assert model = result[:model]
      assert_nil model[:id]
      assert_nil model[:user_id]
      assert_nil model[:name]
      assert_nil model[:password_digest]
      assert_nil model[:number_rooms]
      assert_nil model[:time_limit]
      assert_nil model[:number_damages]
    end
  end
end
