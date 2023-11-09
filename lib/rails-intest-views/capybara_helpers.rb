# frozen_string_literal: true

module RailsIntestViews
  module CapybaraHelpers
    def visit_template(source, **options)
      id = RailsIntestViews.write(source, **options)
      visit RailsIntestViews.url_for(id)
    end
  end
end
