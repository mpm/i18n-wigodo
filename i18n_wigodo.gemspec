lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'i18n_wigodo/version'

Gem::Specification.new do |spec|
  spec.name          = "i18n-wigodo"
  spec.version       = I18nWigodo::VERSION
  spec.license       = 'MIT'
  spec.authors       = ["Malte Münchert"]
  spec.email         = ["malte.muenchert@gmx.net"]

  spec.summary       = %q{Fetch translations from a Google Doc spreadsheet}
  spec.description   = %q{Adds a rake task to your Rails app that lets you fetch your translations from a Google Doc spreadsheet and convert it into YAML}
  spec.homepage      = "https://github.com/mpm/i18n-wigodo"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.5"
  spec.add_development_dependency "rake", "~> 13.2"
  spec.add_development_dependency "rspec", "~> 3.13"
end
