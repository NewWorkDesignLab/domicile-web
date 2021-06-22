module Scenario::Cell
  class Spectate < Domicile::Cell::Base
    include Domicile::Util::Translation

    def get_player_value
      if params[:spectate] == "true"
        return false
      else
        return true
      end
    end

    def link
      return [].tap do |out|
        out << "https://domicile.tobiasbohn.com/app/"
        out << "?scenario=#{params[:id]}"
        out << "&uid=#{cell_object["uid"]}"
        out << "&access-token=#{cell_object["access-token"]}"
        out << "&client=#{cell_object["client"]}"
      end.join('')
    end
  end
end
