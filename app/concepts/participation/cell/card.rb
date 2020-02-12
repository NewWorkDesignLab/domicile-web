module Participation::Cell
  class Card < Domicile::Cell::Base
    include Domicile::Util::Translation

    def participation
      model[:participation]
    end

    def scenario
      participation.scenario
    end

    def subtitle
      [].tap do |out|
        out << "<span class='badge badge-success'>Eigenes Szenario</span>".html_safe if scenario.user[:id] == participation.user[:id]
        out << scenario[:name] if scenario[:name].present?
      end.join('&nbsp;'.html_safe)
    end
  end
end
