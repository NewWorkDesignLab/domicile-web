module Domicile::Cell
  class Base < Trailblazer::Cell
    include Domicile::Util::Form
    include Domicile::CookieHelpers
    include AbstractController::Helpers
    include Devise::Controllers::Helpers
  end
end