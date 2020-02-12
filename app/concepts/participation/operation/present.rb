class Participation::Operation::Present < Trailblazer::Operation
  step Model(Participation, :new)
  step Contract::Build(constant: Participation::Contract::Create)
end