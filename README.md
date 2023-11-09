[![Gem Version](https://badge.fury.io/rb/rails-intest-views.svg)](https://rubygems.org/gems/rails-intest-views)
[![Build](https://github.com/palkan/rails-intest-views/workflows/Build/badge.svg)](https://github.com/palkan/rails-intest-views/actions)

# Rails Intest Views

Generate test views (templates) right from test files. Useful to test UI components (view components, partials, JS, etc.) in isolation.

A quick example of using an inline template to test view components via Rails system tests:

```ruby
class ButtonComponentSystemTest < ApplicationSystemTestCase
  def test_submit_button
    visit_template <<~ERB
      <form id="myForm" onsubmit="event.preventDefault(); this.innerHTML = '';">
        <h2>Self-destructing form</h2>
        <%= render ButtonComponent.new(type: :submit) do %>
          Save me!
        <% end %>
      </form>
    ERB

    assert_text("Self-destructing form")

    click_button("Save me!")

    assert_no_text("Self-destructing form")
  end
end
```

## Installation

Adding gem to your Gemfile:

```ruby
# Gemfile
gem "rails-intest-views", group: :test
```

### Supported Ruby/Rails versions

- Ruby (MRI) >= 2.7.0
- Rails 6+

## Usage

To use intest templates with Capybara, you must first include the helper module:

```ruby
# Minitest
class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
 include RailsIntestViews::CapybaraHelpers

  # ...
end

# RSpec
RSpec.configure do |config|
  config.include RailsIntestViews::CapybaraHelpers, type: :system
end
```

Then, you can use the `#visit_template` helper in your tests:

```ruby
visit_template <<~ERB
  <a href="#">Clicko!</a>
ERB

# some assertions/expectations
```

You can also specify the layout to use:

```ruby
source = <<~ERB
  <a href="#">Clicko!</a>
ERB

visit_template source, layout: "custom"
```

### Configuration

The following configuration parameters are available (the default values are shown):

```ruby
# a controller class used to render templates
config.rails_intest_views.templates_controller = "RailsIntestViews::TemplatesController"
# default layout to use; no layout by default (but you're likely to specify it to load scripts, styles, etc.)
config.rails_intest_views.default_layout = nil
# the mount path for the endpoint (the "/templates/:id" is added to the final URL)
config.rails_intest_views.mount_path = "/rails/intest"
```

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/palkan/rails-intest-views](https://github.com/palkan/rails-intest-views).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
