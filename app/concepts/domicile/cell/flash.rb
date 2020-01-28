module Domicile::Cell
  class Flash < Domicile::Cell::Base
    def flash
      flash = parent_controller.flash
    end
  end
end