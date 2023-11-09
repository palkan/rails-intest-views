# frozen_string_literal: true

require "mutex_m"

module RailsIntestViews
  class Configuration
    attr_accessor :templates_controller, :default_layout, :mount_path

    def initialize
      @mount_path = "/rails/intest"
      @templates_controller = "RailsIntestViews::TemplatesController"
      @default_layout = nil
    end
  end

  class << self
    @@mutex = Mutex.new
    @@store = {}

    def config
      @config ||= Configuration.new
    end

    def find(id)
      @@mutex.synchronize do
        @@store[id]
      end
    end

    def write(template, **options)
      id = nil
      attempts = 5
      catch(:done) do
        loop do
          id = SecureRandom.hex(6)

          @@mutex.synchronize do
            if @@store[id]
              attempts -= 1
              id = nil
              throw :done if attempts < 0
              next
            else
              @@store[id] = {template: template, **options}
              throw :done
            end
          end
        end
      end

      raise "Failed to write template" if id.nil?
      id
    end

    def url_for(id)
      File.join(config.mount_path, id)
    end
  end

  autoload :RequestHelpers, "rails-intest-views/request_helpers"
  autoload :CapybaraHelpers, "rails-intest-views/capybara_helpers"
end

require "rails-intest-views/version"
require "rails-intest-views/engine" if defined?(Rails::Engine)
