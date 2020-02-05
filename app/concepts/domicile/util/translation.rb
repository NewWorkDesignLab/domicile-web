module Domicile::Util
  module Translation
    def self.included(base)
      base.class_eval do
        include ::ActionView::Helpers::TranslationHelper
        include ::Cell::Translation

        self.translation_path = "concepts.#{self.name.underscore}"
      end
    end
  end
end
