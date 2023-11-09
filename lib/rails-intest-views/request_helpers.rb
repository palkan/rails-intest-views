# frozen_string_literal: true

module RailsIntestViews
  module RequestHelpers
    def get_template(source, **options)
      id = RailsIntestViews.write(source, **options)
      get RailsIntestViews.url_for(id)
    end
  end
end
