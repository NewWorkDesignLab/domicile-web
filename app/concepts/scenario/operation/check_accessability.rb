class Scenario::Operation::CheckAccessability < Trailblazer::Operation
  step :check!

  def check!(options, **)
    if options[:current_user].scenarios.exists?(id: options[:id])
      Railway.pass!
    else
      Railway.fail!
    end
  end
end
