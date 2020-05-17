module TestData
  def user
    @user ||= User.first || create_user
  end

  def scenario
    @scenario ||= Scenario.first || create_scenario
  end

  def participation
    @participation ||= Participation.first || create_participation
  end

  def execution
    @execution ||= Execution.first || create_execution
  end

  def user_params(**options)
    ActionController::Parameters.new(
      {
        user: {
          email: Faker::Internet.email,
          password: '12345678',
          password_confirmation: '12345678'
        }.merge(**options)
      }
    )
  end

  def scenario_params(**options)
    ActionController::Parameters.new(
      {
        scenario: {
          name: Faker::Lorem.sentence,
          password: '12345678',
          password_confirmation: '12345678',
          number_rooms: ['1', '2', '3'].sample,
          time_limit: ['0', '5', '10', '15', '20'].sample,
          number_damages: ['2', '3', '4', '5', '6', '7', '8', '9'].sample
        }.merge(**options)
      }
    )
  end

  def participation_params(**options)
    ActionController::Parameters.new(
      {
        participation: {
          scenario_id: options.delete(:scenario_id) || create_scenario[:id],
          password: '12345678'
        }.merge(**options)
      }
    )
  end

  def execution_params(**options)
    ActionController::Parameters.new(
      {
        execution: {
          participation_id: options.delete(:participation_id) || create_participation[:id]
        }.merge(**options)
      }
    )
  end

  def create_user(**options)
    assert result = User::Operation::Create.(params: user_params(options))
    assert result.success?
    assert model = result[:model]
    model
  end

  def create_scenario(**options)
    assert result = Scenario::Operation::Create.(params: scenario_params(options), current_user: options.delete(:user) || create_user)
    assert result.success?
    assert model = result[:model]
    model
  end

  def create_participation(**options)
    assert result = Participation::Operation::Create.(params: participation_params(options), current_user: options.delete(:user) || create_user)
    assert result.success?
    assert model = result[:model]
    model
  end

  def create_execution(**options)
    assert result = Execution::Operation::Create.(params: execution_params(options))
    assert result.success?
    assert model = result[:model]
    model
  end
end
