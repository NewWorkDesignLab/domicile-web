module TestData
  def scenario_params(**options)
    ActionController::Parameters.new(
      {
        scenario: {
          name: 'Test Szenario',
          password: '12345678',
          password_confirmation: '12345678',
          number_rooms: '1', # 1..3
          time_limit: '0', # 0, 5, 10, 15, 20
          number_damages: '2' # 2..9
        }.merge(**options)
      }
    )
  end
end
