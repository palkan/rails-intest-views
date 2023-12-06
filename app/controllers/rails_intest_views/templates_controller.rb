# frozen_string_literal: true

module RailsIntestViews
  class TemplatesController < ActionController::Base
    def show
      template_config = RailsIntestViews.find(params[:id])

      return head :not_found unless template_config

      params = {
        inline: template_config[:template]
      }

      params[:layout] = case template_config
      in {layout: Class => klass}
        proc { klass }
      in {layout: Proc => lambda} if lambda.lambda?
        contents = lambda.call
        proc { contents }
      in {layout: layout}
        layout
      else
        RailsIntestViews.config.default_layout
      end

      render(**params)
    end
  end
end
