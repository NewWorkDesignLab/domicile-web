require 'test_helper'
require 'capybara'
require 'capybara/rails'
require 'selenium-webdriver'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  Capybara.register_driver :selenium_chrome do |app|
    chrome_args = %w[
      disable-dev-shm-usage
      disable-popup-blocking
      ignore-certificate-errors
      no-sandbox
      disable-gpu
      headless
      window-size=1400,1400
    ]

    options = ::Selenium::WebDriver::Chrome::Options.new(args: chrome_args)
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end

  Capybara.default_driver = :selenium_chrome
  Capybara.javascript_driver = :selenium_chrome
  driven_by :selenium_chrome

  def sign_in(**options)
    assert my_user = options.delete(:user) || create_user
    visit new_user_session_path
    assert_current_path(new_user_session_path)
    within '#new_user' do
      fill_in 'Email:', with: my_user[:email]
      fill_in 'Passwort:', with: '12345678'
      click_on 'Anmelden'
    end
    assert_text 'Erfolgreich angemeldet'
    assert_current_path(dashboard_path)
  end

  def sign_out
    click_link 'Abmelden'
    assert_text 'Erfolgreich abgemeldet'
    assert_current_path(new_user_session_path)
  end

  def assert_menu_visible
    within '#navbar-collapse' do
      assert_selector 'a', text: 'Dashboard'
      assert_selector 'a', text: 'Meine Szenarios'
      assert_selector 'a', text: 'Meine Teilnahmen'
      assert_selector 'a', text: 'Einstellungen'
      assert_selector 'a', text: 'Abmelden'
    end
  end
end
