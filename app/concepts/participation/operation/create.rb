class Participation::Operation::Create < Trailblazer::Operation
  step Subprocess(Participation::Operation::Present)

end