class Execution::Operation::Create < Trailblazer::Operation
  step Subprocess(Execution::Operation::Present)
  step Contract::Validate(key: :execution)
  step Contract::Persist()
end
