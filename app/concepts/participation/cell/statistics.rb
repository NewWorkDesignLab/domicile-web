module Participation::Cell
  class Statistics < Domicile::Cell::Base
    include Domicile::Util::Translation

    def participation
      model
    end

    def result_count
      participation.results.count
    end
  end
end
