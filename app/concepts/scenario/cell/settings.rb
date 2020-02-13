module Scenario::Cell
  class Settings < Domicile::Cell::Base
    include Domicile::Util::Translation

    def scenario
      model
    end
  end
end
