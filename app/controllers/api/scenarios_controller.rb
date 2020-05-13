class Api::ScenariosController < Api::BaseController
  before_action -> { check_scenario_accessability!(params[:id]) }

  # Return all Scenarios a User created.
  # GET /api/scenarios
  def index
    render json: current_user.scenarios
  end

  # Return single Scenario.
  # GET /api/scenarios/:id
  def show
    if Scenario.exists?(id: params[:id])
      render json: Scenario.find(params[:id])
    else
      render json: {errors:["Scenario nicht gefunden."]}.to_json, status: :not_found
    end
  end
end
