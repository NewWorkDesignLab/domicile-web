class Participation::Operation::Update < Trailblazer::Operation
  step Model(Participation, :find_by)
  step Contract::Build(constant: Participation::Contract::Update)
  step Contract::Validate(key: :participation)
  step Contract::Persist()
end
