require "rails/generators"

module I18nWigodo
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("templates", __dir__)

    class_option :url, type: :string, default: nil, desc: "URL to translation spreadsheet (Google Docs) [optional]."

    namespace "wigodo:install"

    desc "Create initializer file for Wigodo (put the URL to your spreadsheet there)."
    def create_initializer
      @url = options[:url] || ''
      template "initializer.rb.erb", "config/initializers/wigodo.rb"
    end
  end
end

