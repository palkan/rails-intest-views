# frozen_string_literal: true

module RailsIntestViews
  module RequestHelpers
    def get_template(source, **options)
      id = RailsIntestViews.write(source, **options)
      get RailsIntestViews.url_for(id)
    end

    def get_component(component, **options)
      source = RailsIntestViews.render_component(component)
      get_template(source, **options)
    end
  end
end
