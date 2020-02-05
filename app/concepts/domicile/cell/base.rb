module Domicile::Cell
  class Base < Trailblazer::Cell
    include Domicile::Util::Form
    include Domicile::CookieHelpers
  end
end