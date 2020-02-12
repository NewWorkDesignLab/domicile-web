class Participation::Operation::Create < Trailblazer::Operation
  step Subprocess(Participation::Operation::Present)
  step :set_user!
  step Contract::Validate(key: :participation)
  step Contract::Persist()

  def set_user!(options, current_user:, **)
    options['contract.default'].user = current_user
  end
end