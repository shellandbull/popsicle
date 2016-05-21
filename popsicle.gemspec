# coding: utf-8
gem_name = "popsicle"
lib      = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "#{gem_name}/version"

Gem::Specification.new do |s|
  s.name          = gem_name
  s.version       = Popsicle::VERSION
  s.date          = Time.now.to_s
  s.authors       = ["mariojgintili@gmail.com"]
  s.summary       = "Rack-based web application targeted to serve JavaScript-based client-side applications, like Ember-CLI"
  s.description   = "A tiny Rack app to serve your Ember-CLI apps. Since it's rack-based you can easily mount this on any other framework and enjoy the fun!"
  s.email         = "mariojgintili@gmail.com"
  s.require_paths = ["lib"]

  s.files         = `git ls-files`.split($/)
  s.test_files    = files.grep(%r{^(test|spec|features)/})
  s.homepage      = "https://github.com/mariogintili/popsicle"
  s.license       = "MIT"
end
