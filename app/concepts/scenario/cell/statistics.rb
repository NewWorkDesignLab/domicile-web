module Scenario::Cell
  class Statistics < Domicile::Cell::Base
    include Domicile::Util::Translation

    def scenario
      model
    end

    def result_count
      Participation.joins(:results).where(participations: { scenario_id: scenario[:id] }).count
    end
  end
end
