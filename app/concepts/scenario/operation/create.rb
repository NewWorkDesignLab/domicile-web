class Scenario::Operation::Create < Trailblazer::Operation
  step Subprocess(Scenario::Operation::Present)
  step :define_id!
  step Contract::Validate(key: :scenario)
  step Contract::Persist()
  fail :alert_message!

  def define_id!(options, params:, **)
    params[:scenario][:id]
    while params[:scenario][:id].nil?
      id = rand(10000..99999)
      params[:scenario][:id] = id unless Scenario.exists?(id: id)
    end
    params[:scenario][:id].present?
  end

  def alert_message!(options, **)
    options[:flash_alert] = "Scenario Create Error"
  end
end