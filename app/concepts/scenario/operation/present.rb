class Scenario::Operation::Present < Trailblazer::Operation
  step Model(Scenario, :new)
  step Contract::Build(constant: Scenario::Contract::Create)
end
