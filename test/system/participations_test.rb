require 'application_system_test_case'

class ParticipationsTest < ApplicationSystemTestCase
  test 'should join scenario with password required' do
    sign_in
    assert_current_path(dashboard_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Dashboard'

    click_on 'Meine Teilnahmen'
    assert_current_path(participations_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Meine Teilnahmen'
    assert_text 'Keine Ergebnisse gefunden. Sie können in nur wenigen Schritten einem Szenario beitreten...'
    assert_selector 'a', text: 'Einem Szenario beitreten'

    my_scenario = create_scenario
    click_on 'Einem Szenario beitreten'
    assert_current_path(new_participation_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Einem Szenario beitreten'
    within '#new_participation' do
      assert_text 'Szenario ID: *'
      assert_text 'Passwort:'
      assert_text 'Bitte gebe die ID des Szenarios ein, dem du beitreten möchtest (z.B. 32153)'
      assert_text 'Bitte gebe das Passwort des Szenarios ein. Lasse das Feld frei, wenn es nicht mit einem Passwort versehen ist'
      assert_text '* Dieses Feld ist ein Pflichtfeld'
      assert_selector 'button', text: 'Szenario beitreten'

      fill_in 'Szenario ID:', with: my_scenario.id
      fill_in 'Passwort:', with: '12345678'
    end

    assert_equal 0, Participation.count
    assert_difference 'Participation.count' do
      click_on 'Szenario beitreten'
      assert_text 'Szeanrio erfolgreich beigetreten'
      assert_menu_visible
    end

    sign_out
  end

  test 'should join scenario without password required' do
    sign_in
    assert_current_path(dashboard_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Dashboard'

    click_on 'Meine Teilnahmen'
    assert_current_path(participations_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Meine Teilnahmen'
    assert_text 'Keine Ergebnisse gefunden. Sie können in nur wenigen Schritten einem Szenario beitreten...'
    assert_selector 'a', text: 'Einem Szenario beitreten'

    my_scenario = create_scenario(password: '', password_confirmation: '')
    click_on 'Einem Szenario beitreten'
    assert_current_path(new_participation_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Einem Szenario beitreten'
    within '#new_participation' do
      assert_text 'Szenario ID: *'
      assert_text 'Passwort:'
      assert_text 'Bitte gebe die ID des Szenarios ein, dem du beitreten möchtest (z.B. 32153)'
      assert_text 'Bitte gebe das Passwort des Szenarios ein. Lasse das Feld frei, wenn es nicht mit einem Passwort versehen ist'
      assert_text '* Dieses Feld ist ein Pflichtfeld'
      assert_selector 'button', text: 'Szenario beitreten'

      fill_in 'Szenario ID:', with: my_scenario.id
    end

    assert_equal 0, Participation.count
    assert_difference 'Participation.count' do
      click_on 'Szenario beitreten'
      assert_text 'Szeanrio erfolgreich beigetreten'
      assert_menu_visible
    end

    sign_out
  end

  test 'should show errors on wrong input' do
    sign_in
    assert_current_path(dashboard_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Dashboard'

    click_on 'Meine Teilnahmen'
    assert_current_path(participations_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Meine Teilnahmen'
    assert_text 'Keine Ergebnisse gefunden. Sie können in nur wenigen Schritten einem Szenario beitreten...'
    assert_selector 'a', text: 'Einem Szenario beitreten'

    my_scenario = create_scenario
    my_scenario_without_pw = create_scenario(password: '', password_confirmation: '')

    click_on 'Einem Szenario beitreten'
    assert_current_path(new_participation_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Einem Szenario beitreten'
    within '#new_participation' do
      assert_text 'Szenario ID: *'
      assert_text 'Passwort:'
      assert_text 'Bitte gebe die ID des Szenarios ein, dem du beitreten möchtest (z.B. 32153)'
      assert_text 'Bitte gebe das Passwort des Szenarios ein. Lasse das Feld frei, wenn es nicht mit einem Passwort versehen ist'
      assert_text '* Dieses Feld ist ein Pflichtfeld'
      assert_selector 'button', text: 'Szenario beitreten'

      fill_in 'Szenario ID:', with: my_scenario.id
    end
    assert_equal 0, Participation.count
    assert_no_difference 'Participation.count' do
      click_on 'Szenario beitreten'
      assert_text 'Szenario konnte nicht beigetreten werden. Bitte überprüfen Sie ihre Eingabe'
      assert_text 'Passwort nicht korrekt'
      assert_no_text 'Szeanrio erfolgreich beigetreten'
      assert_menu_visible
    end

    within '#new_participation' do
      fill_in 'Passwort:', with: 'wrong password'
    end
    assert_equal 0, Participation.count
    assert_no_difference 'Participation.count' do
      click_on 'Szenario beitreten'
      assert_text 'Szenario konnte nicht beigetreten werden. Bitte überprüfen Sie ihre Eingabe'
      assert_text 'Passwort nicht korrekt'
      assert_no_text 'Szeanrio erfolgreich beigetreten'
      assert_menu_visible
    end

    within '#new_participation' do
      fill_in 'Passwort:', with: '12345678'
    end
    assert_equal 0, Participation.count
    assert_difference 'Participation.count' do
      click_on 'Szenario beitreten'
      assert_no_text 'Szenario konnte nicht beigetreten werden. Bitte überprüfen Sie ihre Eingabe'
      assert_no_text 'Passwort nicht korrekt'
      assert_text 'Szeanrio erfolgreich beigetreten'
      assert_menu_visible
    end

    assert_selector 'a', text: 'Zurück zur Übersicht'
    click_on 'Zurück zur Übersicht'
    assert_current_path(participations_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Meine Teilnahmen'
    assert_no_text 'Keine Ergebnisse gefunden. Sie können in nur wenigen Schritten einem Szenario beitreten...'
    assert_selector 'a', text: 'Einem Szenario beitreten'

    click_on 'Einem Szenario beitreten'
    assert_current_path(new_participation_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Einem Szenario beitreten'
    within '#new_participation' do
      assert_text 'Szenario ID: *'
      assert_text 'Passwort:'
      assert_text 'Bitte gebe die ID des Szenarios ein, dem du beitreten möchtest (z.B. 32153)'
      assert_text 'Bitte gebe das Passwort des Szenarios ein. Lasse das Feld frei, wenn es nicht mit einem Passwort versehen ist'
      assert_text '* Dieses Feld ist ein Pflichtfeld'
      assert_selector 'button', text: 'Szenario beitreten'

      fill_in 'Szenario ID:', with: my_scenario_without_pw.id
      fill_in 'Passwort:', with: 'no password required'
    end
    assert_equal 1, Participation.count
    assert_difference 'Participation.count' do
      click_on 'Szenario beitreten'
      assert_no_text 'Szenario konnte nicht beigetreten werden. Bitte überprüfen Sie ihre Eingabe'
      assert_no_text 'Passwort nicht korrekt'
      assert_text 'Szeanrio erfolgreich beigetreten'
      assert_menu_visible
    end

    sign_out
  end

  test 'should list participations' do
    assert my_user = create_user
    assert participation_1 = create_participation(user: my_user)
    assert participation_2 = create_participation(user: my_user)
    assert participation_3 = create_participation(user: my_user)
    assert participation_4 = create_participation(user: my_user)

    sign_in(user: my_user)
    assert_current_path(dashboard_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Dashboard'

    click_on 'Meine Teilnahmen'
    assert_current_path(participations_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Meine Teilnahmen'
    assert_no_text 'Keine Ergebnisse gefunden. Sie können in nur wenigen Schritten einem Szenario beitreten...'
    assert_selector 'a', text: 'Einem Szenario beitreten'

    assert_selector '.card-body', count: 4
    assert_selector 'h2', text: '1. Teilnahme'
    assert_selector 'h2', text: '2. Teilnahme'
    assert_selector 'h2', text: '3. Teilnahme'
    assert_selector 'h2', text: '4. Teilnahme'
    assert_selector 'p', text: 'Szenario ID:', count: 4
    assert_selector 'p', text: "Szenario ID: #{participation_1.scenario.id}", count: 1
    assert_selector 'p', text: "Szenario ID: #{participation_2.scenario.id}", count: 1
    assert_selector 'p', text: "Szenario ID: #{participation_3.scenario.id}", count: 1
    assert_selector 'p', text: "Szenario ID: #{participation_4.scenario.id}", count: 1
    assert_selector 'p', text: 'Anzahl Räume', count: 4
    assert_selector 'p', text: 'Zeitlimit', count: 4
    assert_selector 'p', text: 'Anzahl Schäden', count: 4
    assert_selector 'a', text: 'Details', count: 4

    assert participation_5 = create_participation(user: my_user)
    assert participation_6 = create_participation(user: my_user)
    assert participation_7 = create_participation(user: my_user)
    visit(participations_path)
    assert_current_path(participations_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Meine Teilnahmen'
    assert_no_text 'Keine Ergebnisse gefunden. Sie können in nur wenigen Schritten einem Szenario beitreten...'
    assert_selector 'a', text: 'Einem Szenario beitreten'

    assert_selector '.card-body', count: 7
    assert_selector 'h2', text: '4. Teilnahme'
    assert_selector 'h2', text: '5. Teilnahme'
    assert_selector 'h2', text: '6. Teilnahme'
    assert_selector 'h2', text: '7. Teilnahme'
    assert_selector 'p', text: "Szenario ID: #{participation_4.scenario.id}", count: 1
    assert_selector 'p', text: "Szenario ID: #{participation_5.scenario.id}", count: 1
    assert_selector 'p', text: "Szenario ID: #{participation_6.scenario.id}", count: 1
    assert_selector 'p', text: "Szenario ID: #{participation_7.scenario.id}", count: 1
    assert_selector 'p', text: 'Anzahl Räume', count: 7
    assert_selector 'p', text: 'Zeitlimit', count: 7
    assert_selector 'p', text: 'Anzahl Schäden', count: 7
    assert_selector 'a', text: 'Details', count: 7

    sign_out
  end

  test 'should show importand infos on participation show page' do
    skip("Test not implemented yet")
  end

  test 'should show executions on participation show page' do
    skip("Test not implemented yet")
  end

  test 'should destroy participation' do
    skip("Test not implemented yet")
  end
end
