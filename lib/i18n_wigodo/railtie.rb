module I18nWigodo
  class Railtie < Rails::Railtie
    rake_tasks do
      load File.expand_path('../tasks/wigodo.rake', __FILE__)
    end
  end
end
