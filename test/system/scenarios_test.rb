require 'application_system_test_case'

class ScenariosTest < ApplicationSystemTestCase
  test 'should display form correctly and create new scenario with name and password' do
    sign_in
    assert_current_path(dashboard_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Dashboard'

    click_on 'Meine Szenarios'
    assert_current_path(scenarios_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Meine Szenarios'
    assert_text 'Keine Ergebnisse gefunden. Sie können in nur wenigen Schritten ein Szenario erstellen...'
    assert_selector 'a', text: 'Neues Szenario erstellen'

    click_on 'Neues Szenario erstellen'
    assert_current_path(new_scenario_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Neues Szenario'
    within '#new_scenario' do
      assert_text 'Anzahl Räume: *'
      assert_text 'Zeitlimit: *'
      assert_text 'Anzahl Schäden: *'
      assert_no_text 'Name:'
      assert_no_text 'Passwort:'
      assert_no_text 'Passwort bestätigen:'
      assert_text '* Dieses Feld ist ein Pflichtfeld'
      assert_selector 'button', text: 'Erweiterte Einstellungen'
      assert_selector 'button', text: 'Szenario erstellen'
    end

    click_on 'Erweiterte Einstellungen'
    assert_current_path(new_scenario_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Neues Szenario'
    within '#new_scenario' do
      assert_text 'Anzahl Räume: *'
      assert_text 'Zeitlimit: *'
      assert_text 'Anzahl Schäden: *'
      assert_text 'Name:'
      assert_text 'Passwort:'
      assert_text 'Passwort bestätigen:'
      assert_no_text 'Name: *'
      assert_no_text 'Passwort: *'
      assert_no_text 'Passwort bestätigen: *'
      assert_text '* Dieses Feld ist ein Pflichtfeld'
      assert_selector 'button', text: 'Erweiterte Einstellungen'
      assert_selector 'button', text: 'Szenario erstellen'

      select 'ein Raum', from: 'Anzahl Räume:'
      select '2 Räume', from: 'Anzahl Räume:'
      select '3 Räume', from: 'Anzahl Räume:'

      select 'kein Zeitlimit', from: 'Zeitlimit:'
      select '5 Minuten', from: 'Zeitlimit:'
      select '10 Minuten', from: 'Zeitlimit:'
      select '15 Minuten', from: 'Zeitlimit:'
      select '20 Minuten', from: 'Zeitlimit:'

      select '2 Schäden', from: 'Anzahl Schäden:'
      select '3 Schäden', from: 'Anzahl Schäden:'
      select '4 Schäden', from: 'Anzahl Schäden:'
      select '5 Schäden', from: 'Anzahl Schäden:'
      select '6 Schäden', from: 'Anzahl Schäden:'
      select '7 Schäden', from: 'Anzahl Schäden:'
      select '8 Schäden', from: 'Anzahl Schäden:'
      select '9 Schäden', from: 'Anzahl Schäden:'

      fill_in 'Name:', with: 'Test Szenario'
      fill_in 'Passwort:', with: '12345678'
      fill_in 'Passwort bestätigen:', with: '12345678'
    end

    assert_equal 0, Scenario.count
    assert_difference 'Scenario.count' do
      click_on 'Szenario erstellen'
      assert_text 'Szeanrio erfolgreich erstellt'
    end

    sign_out
  end

  test 'should create new scenario without name and password' do
    sign_in
    assert_current_path(dashboard_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Dashboard'

    click_on 'Meine Szenarios'
    assert_current_path(scenarios_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Meine Szenarios'
    assert_text 'Keine Ergebnisse gefunden. Sie können in nur wenigen Schritten ein Szenario erstellen...'
    assert_selector 'a', text: 'Neues Szenario erstellen'

    click_on 'Neues Szenario erstellen'
    assert_current_path(new_scenario_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Neues Szenario'
    within '#new_scenario' do
      assert_text 'Anzahl Räume: *'
      assert_text 'Zeitlimit: *'
      assert_text 'Anzahl Schäden: *'
      assert_no_text 'Name:'
      assert_no_text 'Passwort:'
      assert_no_text 'Passwort bestätigen:'
      assert_text '* Dieses Feld ist ein Pflichtfeld'
      assert_selector 'button', text: 'Erweiterte Einstellungen'
      assert_selector 'button', text: 'Szenario erstellen'

      select '2 Räume', from: 'Anzahl Räume:'
      select '10 Minuten', from: 'Zeitlimit:'
      select '6 Schäden', from: 'Anzahl Schäden:'
    end

    assert_equal 0, Scenario.count
    assert_difference 'Scenario.count' do
      click_on 'Szenario erstellen'
      assert_text 'Szeanrio erfolgreich erstellt'
    end

    sign_out
  end

  test 'should display errors on wrong input' do
    sign_in
    assert_current_path(dashboard_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Dashboard'

    click_on 'Meine Szenarios'
    assert_current_path(scenarios_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Meine Szenarios'
    assert_text 'Keine Ergebnisse gefunden. Sie können in nur wenigen Schritten ein Szenario erstellen...'
    assert_selector 'a', text: 'Neues Szenario erstellen'

    click_on 'Neues Szenario erstellen'
    assert_current_path(new_scenario_path)
    click_on 'Erweiterte Einstellungen'
    assert_current_path(new_scenario_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Neues Szenario'
    within '#new_scenario' do
      select '2 Räume', from: 'Anzahl Räume:'
      select '10 Minuten', from: 'Zeitlimit:'
      select '6 Schäden', from: 'Anzahl Schäden:'
      fill_in 'Name:', with: 'Test Szenario'
      fill_in 'Passwort:', with: '12345678'
      fill_in 'Passwort bestätigen:', with: '1234567'
    end

    assert_equal 0, Scenario.count
    assert_no_difference 'Scenario.count' do
      click_on 'Szenario erstellen'
      assert_current_path(scenarios_path)
      assert_text 'Szenario konnte nicht erstellt werden. Bitte überprüfen Sie ihre Eingabe'
    end

    sign_out
  end

  test 'should list created scenarios' do
    assert my_user = create_user
    assert scenario_1 = create_scenario(user: my_user)
    assert scenario_2 = create_scenario(user: my_user)
    assert scenario_3 = create_scenario(user: my_user)
    assert scenario_4 = create_scenario(user: my_user)

    sign_in(user: my_user)
    assert_current_path(dashboard_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Dashboard'

    click_on 'Meine Szenarios'
    assert_current_path(scenarios_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Meine Szenarios'
    assert_no_text 'Keine Ergebnisse gefunden. Sie können in nur wenigen Schritten ein Szenario erstellen...'
    assert_selector 'a', text: 'Neues Szenario erstellen'

    assert_selector '.card-body', count: 4
    assert_selector 'h2', text: '1. Szenario'
    assert_selector 'h2', text: '2. Szenario'
    assert_selector 'h2', text: '3. Szenario'
    assert_selector 'h2', text: '4. Szenario'
    assert_selector 'p', text: 'Anzahl Teilnehmer: 0', count: 4
    assert_selector 'p', text: 'Anzahl Ausführungen: 0', count: 4
    assert_selector 'a', text: 'Details', count: 4

    assert scenario_5 = create_scenario(user: my_user)
    assert scenario_6 = create_scenario(user: my_user)
    assert scenario_7 = create_scenario(user: my_user)
    visit(scenarios_path)
    assert_current_path(scenarios_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Meine Szenarios'
    assert_no_text 'Keine Ergebnisse gefunden. Sie können in nur wenigen Schritten ein Szenario erstellen...'
    assert_selector 'a', text: 'Neues Szenario erstellen'

    assert_selector '.card-body', count: 7
    assert_selector 'h2', text: '4. Szenario'
    assert_selector 'h2', text: '5. Szenario'
    assert_selector 'h2', text: '6. Szenario'
    assert_selector 'h2', text: '7. Szenario'
    assert_selector 'p', text: 'Anzahl Teilnehmer: 0', count: 7
    assert_selector 'p', text: 'Anzahl Ausführungen: 0', count: 7
    assert_selector 'a', text: 'Details', count: 7

    sign_out
  end

  test 'should show importand infos on scenario show page' do
    assert my_user = create_user
    assert my_scenario = create_scenario(user: my_user, number_rooms: '1', number_damages: '4', time_limit: '10')

    sign_in(user: my_user)
    assert_current_path(dashboard_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Dashboard'

    visit(scenario_path(my_scenario.id))
    assert_current_path(scenario_path(my_scenario.id))
    assert_menu_visible
    assert_selector 'h1', text: 'Mein Szenario - Übersicht'
    assert_selector 'h2', text: my_scenario.name
    assert_selector 'a', text: 'Zurück zur Übersicht'
    assert_selector 'a', text: 'Szenario beitreten'

    assert_selector 'h3', text: 'Übersicht der Einstellungen:'
    assert_text "Szenario ID: #{my_scenario.id}"
    assert_text 'Anzahl Räume: ein Raum'
    assert_text 'Zeitlimit: 10 Minuten'
    assert_text 'Anzahl Schäden: 4 Schäden'

    assert_selector 'h3', text: 'Statistiken:'
    assert_text 'Anzahl Teilnehmer: 0'
    assert_text 'Anzahl Ausführungen: 0'

    assert participation_1 = create_participation(scenario_id: my_scenario[:id])
    assert participation_2 = create_participation(scenario_id: my_scenario[:id])
    assert execution_1 = create_execution(participation_id: participation_1[:id])
    assert execution_2 = create_execution(participation_id: participation_1[:id])
    assert execution_3 = create_execution(participation_id: participation_2[:id])

    visit(scenario_path(my_scenario.id))
    assert_current_path(scenario_path(my_scenario.id))
    assert_menu_visible
    assert_selector 'h1', text: 'Mein Szenario - Übersicht'
    assert_selector 'h2', text: my_scenario.name
    assert_selector 'a', text: 'Zurück zur Übersicht'
    assert_selector 'a', text: 'Szenario beitreten'

    assert_selector 'h3', text: 'Übersicht der Einstellungen:'
    assert_text "Szenario ID: #{my_scenario.id}"
    assert_text 'Anzahl Räume: ein Raum'
    assert_text 'Zeitlimit: 10 Minuten'
    assert_text 'Anzahl Schäden: 4 Schäden'

    assert_selector 'h3', text: 'Statistiken:'
    assert_text 'Anzahl Teilnehmer: 2'
    assert_text 'Anzahl Ausführungen: 3'

    sign_out
  end

  test 'should show participations on scenario show page' do
    assert my_user = create_user
    assert my_scenario = create_scenario(user: my_user)

    sign_in(user: my_user)
    assert_current_path(dashboard_path)
    assert_menu_visible
    assert_selector 'h1', text: 'Dashboard'

    visit(scenario_path(my_scenario.id))
    assert_current_path(scenario_path(my_scenario.id))
    assert_menu_visible
    assert_selector 'h1', text: 'Mein Szenario - Übersicht'
    assert_selector 'h2', text: my_scenario.name
    assert_selector 'h3', text: 'Statistiken:'
    assert_text 'Anzahl Teilnehmer: 0'
    assert_text 'Anzahl Ausführungen: 0'
    assert_text 'Es sind noch keine Teilnehmer vorhanden'
    assert_selector 'tr.table-sm', count: 1

    assert participation_1 = create_participation(scenario_id: my_scenario[:id])
    assert participation_2 = create_participation(scenario_id: my_scenario[:id])
    assert participation_3 = create_participation(scenario_id: my_scenario[:id])

    visit(scenario_path(my_scenario.id))
    assert_current_path(scenario_path(my_scenario.id))
    assert_menu_visible
    assert_selector 'h1', text: 'Mein Szenario - Übersicht'
    assert_selector 'h2', text: my_scenario.name
    assert_selector 'h3', text: 'Statistiken:'
    assert_text 'Anzahl Teilnehmer: 3'
    assert_text 'Anzahl Ausführungen: 0'
    assert_no_text 'Es sind noch keine Teilnehmer vorhanden'
    assert_selector 'tr.table-sm', count: 3
    assert_text participation_1.user[:email]
    assert_text participation_2.user[:email]
    assert_text participation_3.user[:email]

    sign_out
  end

  test 'should destroy scenario' do
    skip("Test not implemented yet")
  end
end
