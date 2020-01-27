module Domicile::Cell
  class Base < Trailblazer::Cell
    def default_url_options
      { lang: I18n.locale }
    end
  end
end