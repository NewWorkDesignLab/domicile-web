require 'test_helper'

class Execution::Operation::PresentTest < ActiveSupport::TestCase
  test 'should present execution' do
    assert_no_difference 'Execution.count' do
      params = {}
      assert result = Scenario::Operation::Present.(params: params)
      assert result.success?
      assert model = result[:model]
      assert_nil model[:id]
      assert_nil model[:participation_id]
    end
  end
end
