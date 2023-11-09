# frozen_string_literal: true

module RailsIntestViews
  class TemplatesController < ActionController::Base
    def show
      template_config = RailsIntestViews.find(params[:id])

      return head :not_found unless template_config

      params = {
        inline: template_config[:template],
        layout: RailsIntestViews.config.default_layout
      }

      params[:layout] = template_config[:layout] if template_config.key?(:layout)

      render(**params)
    end
  end
end
