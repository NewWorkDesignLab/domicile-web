module Scenario::Cell
  class Statistics < Domicile::Cell::Base
    include Domicile::Util::Translation

    def execution_count
      Participation.joins(:executions).where(participations: { scenario_id: cell_object[:id] }).count
    end
  end
end
