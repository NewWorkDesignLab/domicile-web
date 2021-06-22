class Scenario::Operation::Update < Trailblazer::Operation
  step Subprocess(Scenario::Operation::Edit)
  step Contract::Validate(key: :scenario)
  step Contract::Persist()
end
