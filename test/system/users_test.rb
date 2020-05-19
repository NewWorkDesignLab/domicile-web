require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'should register user' do
    visit '/'
    assert_current_path(new_user_session_path)
    assert_selector 'h1', text: 'Anmelden'
    assert_text 'Email: *'
    assert_text 'Passwort: *'
    assert_text '* Dieses Feld ist ein Pflichtfeld'
    assert_selector 'button', text: 'Anmelden'
    assert_selector 'a', text: 'Registrieren'
    assert_selector 'a', text: 'Passwort vergessen?'
    assert_selector 'a', text: 'Bestätigungslink nicht erhalten?'

    click_on 'Registrieren'
    assert_current_path(new_user_registration_path)

    assert_selector 'h1', text: 'Registrieren'
    assert_text 'Email: *'
    assert_text 'Passwort: *'
    assert_text 'Passwort bestätigen: *'
    assert_text '* Dieses Feld ist ein Pflichtfeld'
    assert_selector 'button', text: 'Registrieren'
    assert_selector 'a', text: 'Anmelden'
    assert_selector 'a', text: 'Bestätigungslink nicht erhalten?'

    skip("Known Issue: No Emails send on Registration")
    assert_email_send do
      within '#new_user' do
        fill_in 'Email:', with: 'info@tobiasbohn.com'
        fill_in 'Passwort:', with: '12345678'
        fill_in 'Passwort bestätigen:', with: '12345678'
        click_on 'Registrieren'
      end

      assert_current_path(new_user_session_path)
      assert_selector 'h1', text: 'Anmelden'
      assert_text 'Du erhältst in wenigen Minuten eine E-Mail mit einem Link für die Bestätigung der Registrierung. Klicke auf den Link um Dein Konto zu aktivieren.'
    end
  end

  test 'should not register user with wrong email or password' do
    visit '/'
    assert_current_path(new_user_session_path)
    click_on 'Registrieren'
    assert_current_path(new_user_registration_path)

    assert_selector 'h1', text: 'Registrieren'
    assert_text 'Email: *'
    assert_text 'Passwort: *'
    assert_text 'Passwort bestätigen: *'
    assert_text '* Dieses Feld ist ein Pflichtfeld'
    assert_selector 'button', text: 'Registrieren'
    assert_selector 'a', text: 'Anmelden'
    assert_selector 'a', text: 'Bestätigungslink nicht erhalten?'

    assert_no_email_send do
      within '#new_user' do
        fill_in 'Email:', with: 'keine Mail'
        fill_in 'Passwort:', with: '12345678'
        fill_in 'Passwort bestätigen:', with: '12345678'
        click_on 'Registrieren'
      end

      assert_current_path(user_registration_path)
      assert_selector 'h1', text: 'Registrieren'
      assert_text 'ist keine E-Mail-Adresse'
    end

    visit new_user_registration_path
    assert_no_email_send do
      within '#new_user' do
        fill_in 'Email:', with: 'info@tobiasbohn.com'
        fill_in 'Passwort:', with: '12345678'
        fill_in 'Passwort bestätigen:', with: '123456789'
        click_on 'Registrieren'
      end

      assert_current_path(user_registration_path)
      assert_selector 'h1', text: 'Registrieren'
      assert_text 'stimmt nicht mit Passwort überein'
    end
  end

  test 'should require confirmation' do
    visit '/'
    assert_current_path(new_user_session_path)

    assert_selector 'h1', text: 'Anmelden'
    assert_text 'Email: *'
    assert_text 'Passwort: *'
    assert_text '* Dieses Feld ist ein Pflichtfeld'
    assert_selector 'button', text: 'Anmelden'

    my_user = create_unconfirmed_user
    within '#new_user' do
      fill_in 'Email:', with: my_user[:email]
      fill_in 'Passwort:', with: '12345678'
      click_on 'Anmelden'
    end

    assert_current_path(new_user_session_path)
    assert_selector 'h1', text: 'Anmelden'
    assert_text 'Du musst Dein Konto bestätigen, bevor Du fortfahren kannst.'
  end

  test 'should resend confirmation mail only to unconfirmed emails' do
    visit '/'
    my_unconfirmed_user = create_unconfirmed_user
    my_confirmed_user = create_user
    assert_current_path(new_user_session_path)

    assert_selector 'h1', text: 'Anmelden'
    assert_selector 'a', text: 'Bestätigungslink nicht erhalten?'
    click_on 'Bestätigungslink nicht erhalten?'

    assert_current_path(new_user_confirmation_path)
    assert_selector 'h1', text: 'Bestätigungslink erneut senden'
    assert_text 'Email: *'
    assert_text '* Dieses Feld ist ein Pflichtfeld'
    assert_selector 'button', text: 'Link zusenden'

    assert_no_email_send do
      within '#new_user' do
        fill_in 'Email:', with: my_confirmed_user[:email]
        click_on 'Link zusenden'
      end

      assert_current_path(user_confirmation_path)
      assert_selector 'h1', text: 'Bestätigungslink erneut senden'
      assert_text 'wurde bereits bestätigt, bitte versuche, Dich anzumelden'
    end

    visit new_user_confirmation_path
    assert_current_path(new_user_confirmation_path)
    assert_no_email_send do
      within '#new_user' do
        fill_in 'Email:', with: 'unbekannte.mail@tobiasbohn.com'
        click_on 'Link zusenden'
      end

      assert_current_path(user_confirmation_path)
      assert_selector 'h1', text: 'Bestätigungslink erneut senden'
      assert_text 'nicht gefunden'
    end

    visit new_user_confirmation_path
    assert_current_path(new_user_confirmation_path)
    assert_email_send do
      within '#new_user' do
        fill_in 'Email:', with: my_unconfirmed_user[:email]
        click_on 'Link zusenden'
      end

      assert_current_path(new_user_session_path)
      assert_selector 'h1', text: 'Anmelden'
      assert_text 'Du erhältst in wenigen Minuten eine E-Mail, mit der Du Deine Registrierung bestätigen kannst.'
    end
  end

  test 'should send password reset instructions' do
    visit '/'
    assert_current_path(new_user_session_path)
    assert_selector 'h1', text: 'Anmelden'
    assert_selector 'a', text: 'Passwort vergessen?'
    click_on 'Passwort vergessen?'

    assert_current_path(new_user_password_path)
    assert_selector 'h1', text: 'Passwort zurücksetzen'
    assert_text 'Email: *'
    assert_text '* Dieses Feld ist ein Pflichtfeld'
    assert_selector 'button', text: 'Passwort zurücksetzen'

    assert_no_email_send do
      within '#new_user' do
        fill_in 'Email:', with: 'unbekannte.mail@tobiasbohn.com'
        click_on 'Passwort zurücksetzen'
      end

      assert_current_path(user_password_path)
      assert_selector 'h1', text: 'Passwort zurücksetzen'
      assert_text 'nicht gefunden'
    end

    visit new_user_password_path
    assert_current_path(new_user_password_path)

    my_confirmed_user = create_user
    assert_email_send do
      within '#new_user' do
        fill_in 'Email:', with: my_confirmed_user[:email]
        click_on 'Passwort zurücksetzen'
      end

      assert_current_path(new_user_session_path)
      assert_selector 'h1', text: 'Anmelden'
      assert_text 'Du erhältst in wenigen Minuten eine E-Mail mit der Anleitung, wie Du Dein Passwort zurücksetzen kannst.'
    end
  end

  test 'should login and logut' do
    visit '/'
    assert_current_path(new_user_session_path)
    assert_selector 'h1', text: 'Anmelden'
    assert_text 'Email: *'
    assert_text 'Passwort: *'
    assert_text '* Dieses Feld ist ein Pflichtfeld'
    assert_selector 'button', text: 'Anmelden'
    assert_selector 'a', text: 'Registrieren'
    assert_selector 'a', text: 'Passwort vergessen?'
    assert_selector 'a', text: 'Bestätigungslink nicht erhalten?'

    my_user = create_user
    within '#new_user' do
      fill_in 'Email:', with: my_user[:email]
      fill_in 'Passwort:', with: '12345678'
      click_on 'Anmelden'
    end
    assert_current_path(dashboard_path)
    assert_text 'Erfolgreich angemeldet'
    assert_menu_visible

    click_on 'Abmelden'
    assert_current_path(new_user_session_path)
    assert_text 'Erfolgreich abgemeldet'
    assert_selector 'h1', text: 'Anmelden'
  end

  test 'should change account data' do
    sign_in
    skip("Test not implemented yet")
  end
end
