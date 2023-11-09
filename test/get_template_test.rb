# frozen_string_literal: true

require "test_helper"

class IntestTemplateUrlTest < ActionDispatch::IntegrationTest
  include RailsIntestViews::RequestHelpers

  def test_default
    get_template <<~ERB
      <a href="#">Clicko!</a>
    ERB

    assert_empty css_select("h1")
    assert_select "a", "Clicko!"
  end

  def test_with_global_layout
    Rails.configuration.rails_intest_views.default_layout = "application"

    get_template <<~ERB
      <a href="#">Clicko!</a>
    ERB

    assert_select "h1", "Default template"
    assert_select "a", "Clicko!"
  ensure
    Rails.configuration.rails_intest_views.default_layout = nil
  end

  def test_with_custom_layout
    template = <<~ERB
      <a href="#">Clicko!</a>
    ERB

    get_template template, layout: "custom"

    assert_select "h1", "Custom template"
    assert_select "a", "Clicko!"
  end

  def test_unknown_template
    get RailsIntestViews.url_for("unknown")

    assert_response :not_found
  end
end
