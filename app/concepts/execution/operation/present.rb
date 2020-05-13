class Execution::Operation::Present < Trailblazer::Operation
  step Model(Execution, :new)
  step Contract::Build(constant: Execution::Contract::Create)
end
