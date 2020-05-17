require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'should register user' do
    visit '/'
    assert_selector 'h1', text: 'Anmelden'
  end
end
