class User::Operation::Create < Trailblazer::Operation
  step Subprocess(User::Operation::Present)
  step Contract::Validate(key: :user)
  step Contract::Persist()
end
