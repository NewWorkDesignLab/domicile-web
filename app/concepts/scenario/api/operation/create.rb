class Scenario::Api::Operation::Create < Trailblazer::Operation
  step :require_pass!, fast_track: true
  step Subprocess(Scenario::Operation::Create)
  fail :error_subprocess!, fast_track: true
  step :model!
  fail :error!

  def require_pass!(options, params:, **)
    if params[:scenario][:password].present?
      Railway.pass!
    else
      options[:api_error] = :please_specify_password
      Railway.fail_fast!
    end
  end

  def error_subprocess!(options, **)
    if options['result.contract.default'].errors.details.key?(:legal)
      options[:api_error] = :accept_legals_required
    elsif options['result.contract.default'].errors.details.key?(:number_rooms)
      error = options['result.contract.default'].errors.details[:number_rooms].first[:error].to_s
      options[:api_error] = "number_rooms_error_#{error}"
    elsif options['result.contract.default'].errors.details.key?(:time_limit)
      error = options['result.contract.default'].errors.details[:time_limit].first[:error].to_s
      options[:api_error] = "time_limit_error_#{error}"
    elsif options['result.contract.default'].errors.details.key?(:number_damages)
      error = options['result.contract.default'].errors.details[:number_damages].first[:error].to_s
      options[:api_error] = "number_damages_error_#{error}"
    elsif options['result.contract.default'].errors.details.key?(:password)
      error = options['result.contract.default'].errors.details[:password].first[:error].to_s
      options[:api_error] = "password_error_#{error}"
    else
      options[:api_error] = :unknown_subprocess_error
    end
    Railway.fail_fast!
  end

  def model!(options, model:, **)
    options[:api_model] = Scenario.where(id: model[:id]).select(:id, :number_rooms, :time_limit, :number_damages, :created_at, :updated_at).take
  end

  def error!(options, **)
    options[:api_error] = :unknown_error
  end
end
