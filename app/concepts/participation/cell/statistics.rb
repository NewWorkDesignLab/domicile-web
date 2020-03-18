module Participation::Cell
  class Statistics < Domicile::Cell::Base
    include Domicile::Util::Translation

    def participation
      model
    end

    def executions_count
      participation.executions.count
    end
  end
end
