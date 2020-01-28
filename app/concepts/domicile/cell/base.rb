module Domicile::Cell
  class Base < Trailblazer::Cell
    include Domicile::Util::Form
    include Domicile::CookieHelpers

    def default_url_options
      { lang: I18n.locale }
    end
  end
end