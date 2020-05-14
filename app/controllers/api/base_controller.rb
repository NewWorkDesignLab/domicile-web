class Api::BaseController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session
  before_action :authenticate_user!

  private

  def check_scenario_accessability!(id)
    if id.present?
      if !current_user.scenarios.exists?(id: id) && !current_user.participated_scenarios.exists?(id: id)
        render json: {errors:["Szenario nicht gefunden."]}.to_json, status: :not_found
      end
    end
  end

  def check_participation_accessability!(id)
    if id.present?
      if !current_user.available_participations.exists?(id: id)
        render json: {errors:["Teilnahme nicht gefunden."]}.to_json, status: :not_found
      end
    end
  end

  def check_execution_accessability!(id)
    if id.present?
      if !current_user.executions.exists?(id: id) && !current_user.hosted_executions.exists?(id: id)
        render json: {errors:["Ergebniss nicht gefunden."]}.to_json, status: :not_found
      end
    end
  end
end
