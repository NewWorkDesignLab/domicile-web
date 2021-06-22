module Domicile::Cell
  class Navigation < Domicile::Cell::Base
    include Domicile::Util::Translation

    def check_active(controllers, actions = [])
      if controllers.include?(params[:controller])
        if actions.blank?
          " active"
        elsif actions.include?(params[:action])
          " active"
        end
      end
    end
  end
end
