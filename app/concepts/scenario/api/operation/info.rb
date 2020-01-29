class Scenario::Api::Operation::Info < Trailblazer::Operation
  step :require_id!, fast_track: true
  step :model!, fast_track: true
  step :require_pass!, fast_track: true
  step :authenticate!
  fail :error!

  def require_id!(options, params: {}, **)
    if params[:id].present? && params[:id].match(/\d{5}/)
      options[:id] = params[:id]
      Railway.pass!
    else
      options[:api_error] = :invalid_id
      Railway.fail_fast!
    end
  end

  def model!(options, id:, **)
    if Scenario.exists?(id: id)
      options[:model] = Scenario.find(id)
      Railway.pass!
    else
      options[:api_error] = :unknown_scenario
      Railway.fail_fast!
    end
  end

  def require_pass!(options, params: {}, **)
    if params[:password].present?
      options[:password] = params[:password]
      Railway.pass!
    else
      options[:api_error] = :invalid_password
      Railway.fail_fast!
    end
  end

  def authenticate!(options, model:, password:, **)
    if model.authenticate(password)
      options[:api_model] = Scenario.where(id: model.id).select(:id, :number_rooms, :time_limit, :number_damages, :created_at, :updated_at).take
      Railway.pass!
    else
      options[:api_error] = :authentification_failed
      Railway.fail!
    end
  end

  def error!(options, **)
    options[:api_error] = :unknown_error
  end
end
