module Scenario::Cell
  class Show < Domicile::Cell::Base
    def scenario
      Scenario.find_by(id: params[:id])
    end
  end
end