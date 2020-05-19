require 'application_system_test_case'

class PagesTest < ApplicationSystemTestCase
  test 'root page should show login page if not logged in' do
    visit '/'
    assert_current_path(new_user_session_path)
  end

  test 'root page should show dashboard if logged in' do
    sign_in
    visit '/'
    assert_current_path(dashboard_path)
  end
end
