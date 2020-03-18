module Scenario::Cell
  class Statistics < Domicile::Cell::Base
    include Domicile::Util::Translation

    def scenario
      model
    end

    def execution_count
      Participation.joins(:executions).where(participations: { scenario_id: scenario[:id] }).count
    end
  end
end
