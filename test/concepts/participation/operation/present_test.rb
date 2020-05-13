require 'test_helper'

class Participation::Operation::PresentTest < ActiveSupport::TestCase
  test 'should present participation' do
    assert_no_difference 'Participation.count' do
      params = {}
      assert result = Participation::Operation::Present.(params: params)
      assert result.success?
      assert model = result[:model]
      assert_nil model[:id]
      assert_nil model[:user_id]
      assert_nil model[:scenario_id]
    end
  end
end
