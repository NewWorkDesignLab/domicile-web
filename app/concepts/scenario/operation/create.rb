class Scenario::Operation::Create < Trailblazer::Operation
  step Subprocess(Scenario::Operation::Present)
  step :set_user!
  step :define_id!
  step Contract::Validate(key: :scenario)
  step Contract::Persist()

  def set_user!(options, current_user:, **)
    options['contract.default'].user = current_user
  end

  def define_id!(options, **)
    id = nil
    while id.nil?
      random_id = rand(10000..99999)
      id = random_id unless Scenario.exists?(id: random_id)
    end
    options['contract.default'].id = id
  end
end
