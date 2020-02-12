module Scenario::Cell
  class Card < Domicile::Cell::Base
    include Domicile::Util::Translation

    def scenario
      model[:scenario]
    end
  end
end
