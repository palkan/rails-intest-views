# frozen_string_literal: true

module RailsIntestViews # :nodoc:
  class Engine < ::Rails::Engine # :nodoc:
    config.rails_intest_views = RailsIntestViews.config

    config.after_initialize do |app|
      options = app.config.rails_intest_views

      app.routes.prepend do
        templates_controller = options.templates_controller.sub(/Controller$/, "").underscore

        get(
          File.join(options.mount_path, ":id"),
          to: "#{templates_controller}#show",
          as: :rails_intest_view,
          internal: true
        )
      end
    end
  end
end
