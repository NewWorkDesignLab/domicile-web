require 'test_helper'

class User::Operation::PresentTest < ActiveSupport::TestCase
  test 'should present user' do
    assert_no_difference 'User.count' do
      params = {}
      assert result = User::Operation::Present.(params: params)
      assert result.success?
      assert model = result[:model]

      assert_nil model[:id]
      assert_equal "", model[:email]
      assert_nil model[:password_digest]
    end
  end
end
