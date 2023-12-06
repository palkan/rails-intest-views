# frozen_string_literal: true

require "test_helper"

class RenderComponentTest < ActionDispatch::IntegrationTest
  include RailsIntestViews::RequestHelpers

  class Clicko
    def render_in(*)
      <<~ERB
        <a href="#">Clicko!</a>
      ERB
    end

    def format
      :html
    end
  end

  class CustomLayout
    class << self
      def render(*)
        "<h1>Custom template</h1>" + yield
      end
      alias_method :identifier, :to_s
      alias_method :virtual_path, :to_s
    end
  end

  def test_default
    get_component Clicko.new

    assert_empty css_select("h1")
    assert_select "a", "Clicko!"
  end

  def test_with_global_layout
    Rails.configuration.rails_intest_views.default_layout = "application"

    get_component Clicko.new

    assert_select "h1", "Default template"
    assert_select "a", "Clicko!"
  ensure
    Rails.configuration.rails_intest_views.default_layout = nil
  end

  def test_with_component_layout
    get_component Clicko.new, layout: CustomLayout

    assert_select "h1", "Custom template"
    assert_select "a", "Clicko!"
  end

  def test_with_lambda_layout
    get_component Clicko.new, layout: -> { CustomLayout }

    assert_select "h1", "Custom template"
    assert_select "a", "Clicko!"
  end
end
