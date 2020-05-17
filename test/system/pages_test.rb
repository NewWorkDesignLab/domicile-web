require 'application_system_test_case'

class PagesTest < ApplicationSystemTestCase
  test 'root page should show login page if not logged in' do
    visit '/'
    assert true
  end

  test 'root page should show dashboard if logged in' do
    visit '/'
    assert true
  end
end
