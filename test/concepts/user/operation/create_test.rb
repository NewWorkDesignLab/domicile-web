require 'test_helper'

class User::Operation::CreateTest < ActiveSupport::TestCase
  test 'should succeed creating user' do
    assert_difference 'User.count' do
      assert result = User::Operation::Create.(
        params: user_params
      )
      assert result.success?
      assert result['contract.default'].errors.blank?
      assert model = result[:model]
      assert model[:id].present?
      assert model[:email].present?
      assert model[:encrypted_password].present?
    end
  end
end
