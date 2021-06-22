class Scenario::Operation::Edit < Trailblazer::Operation
  step :find_scenario_via_user!
  step Contract::Build(constant: Scenario::Contract::Update)

  def find_scenario_via_user!(options, params:, current_user:, **)
    if current_user.hosted_scenarios_only.exists?(params[:id])
      options[:model] = current_user.hosted_scenarios_only.find_by(id: params[:id])
    else
      Railway.fail!
    end
  end
end
