class Participation::Operation::CheckAccessability < Trailblazer::Operation
  step :false!

  def false!(options, **)
    Railway.fail!
  end
end
