class Participation::Operation::Create < Trailblazer::Operation
  step Subprocess(Participation::Operation::Present)
  step :set_user!
  step :set_role!
  step Contract::Validate(key: :participation)
  step Contract::Persist()

  def set_user!(options, current_user:, **)
    options['contract.default'].user = current_user
  end

  def set_role!(options, params:, current_user:, **)
    scenario = Scenario.find_by(id: params.dig(:participation, :scenario_id))
    if scenario&.user == current_user
      options['contract.default'].role = 'owner'
    else
      options['contract.default'].role = 'player'
    end
  end
end
