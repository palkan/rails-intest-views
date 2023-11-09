# frozen_string_literal: true

RailsIntestViews::Engine.routes.draw do
  get "/template/:id", to: "templates#show", as: :rails_intest_template
end
