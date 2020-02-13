module Participation::Cell
  class Show < Domicile::Cell::Base
    include Domicile::Util::Translation

    def participation
      model
    end

    def scenario
      model.scenario
    end
  end
end