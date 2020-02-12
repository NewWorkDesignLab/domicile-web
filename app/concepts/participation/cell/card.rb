module Participation::Cell
  class Card < Domicile::Cell::Base
    include Domicile::Util::Translation

    def participation
      model[:participation]
    end
  end
end
