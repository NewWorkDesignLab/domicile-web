module Scenario::Cell
  class Show < Domicile::Cell::Base
    include Domicile::Util::Translation

    def scenario
      model
    end
  end
end