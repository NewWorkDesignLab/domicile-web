module Domicile::Cell
  class Base < Trailblazer::Cell
    include Domicile::Util::Form
    include Domicile::CookieHelpers
    include AbstractController::Helpers
    include Devise::Controllers::Helpers

    def current_user
      model[:current_user]
    end

    def cell_object
      model[:object] || model
    end

    def collection_rooms
      [].tap do |out|
        out << [t('concepts.scenario.cell.new.settings.room', count: 1), 1]
        out << [t('concepts.scenario.cell.new.settings.room', count: 2), 2]
        out << [t('concepts.scenario.cell.new.settings.room', count: 3), 3]
      end
    end

    def collection_time
      [].tap do |out|
        out << [t('concepts.scenario.cell.new.settings.time', count: 0), 0]
        out << [t('concepts.scenario.cell.new.settings.time', count: 5), 5]
        out << [t('concepts.scenario.cell.new.settings.time', count: 10), 10]
        out << [t('concepts.scenario.cell.new.settings.time', count: 15), 15]
        out << [t('concepts.scenario.cell.new.settings.time', count: 20), 20]
      end
    end

    def collection_damages
      [].tap do |out|
        out << [t('concepts.scenario.cell.new.settings.damage', count: 2), 2]
        out << [t('concepts.scenario.cell.new.settings.damage', count: 3), 3]
        out << [t('concepts.scenario.cell.new.settings.damage', count: 4), 4]
        out << [t('concepts.scenario.cell.new.settings.damage', count: 5), 5]
        out << [t('concepts.scenario.cell.new.settings.damage', count: 6), 6]
        out << [t('concepts.scenario.cell.new.settings.damage', count: 7), 7]
        out << [t('concepts.scenario.cell.new.settings.damage', count: 8), 8]
        out << [t('concepts.scenario.cell.new.settings.damage', count: 9), 9]
      end
    end
  end
end
