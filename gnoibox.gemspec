$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "gnoibox/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "gnoibox"
  s.version     = Gnoibox::VERSION
  s.authors     = ["Youhei Furukawa"]
  s.email       = ["gnattali@gmail.com"]
  s.homepage    = "http://www.infoathletes.com"
  s.summary     = "CMS with multi dimensional search"
  s.description = "CMS with multi dimensional search"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.0.0"

  s.add_dependency 'haml-rails', '>= 0.4'
  s.add_dependency 'kaminari', '>= 0.14.1'
  s.add_dependency 'acts-as-taggable-on', '>= 3.0.0'
  s.add_dependency 'devise', '>= 3.2.0'
  s.add_dependency 'simple_form', '>= 3.0.0'
  s.add_dependency 'mini_magick', '>= 3.6.0'
  s.add_dependency 'carrierwave', '>= 0.9.0'
  s.add_dependency 'fog', '>= 1.18.0'
  # s.add_dependency 'draper', '>= 1.3.0'
  # s.add_dependency 'acts_as_list', '>= 0.3.0'

  s.add_development_dependency "sqlite3"
end
