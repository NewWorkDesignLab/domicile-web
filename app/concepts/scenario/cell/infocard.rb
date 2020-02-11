module Scenario::Cell
  class Infocard < Domicile::Cell::Base
    include Domicile::Util::Translation

    def scenario
      model[:scenario]
    end
  end
end