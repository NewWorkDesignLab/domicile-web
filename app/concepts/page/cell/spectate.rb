module Page::Cell
  class Spectate < Domicile::Cell::Base
    include Domicile::Util::Translation

    def get_player_value
      if params[:spectate] == "true"
        return false
      else
        return true
      end
    end
  end
end
