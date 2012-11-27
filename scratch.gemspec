$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "scratch/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "scratch"
  s.version     = Scratch::VERSION
  s.authors     = ["Nicolas Buduroi"]
  s.email       = ["nbuduroi@gmail.com"]
  s.homepage    = "http://github.com/budu/Scratch"
  s.summary     = "A plugin to relieve from some Rails itches."
  s.description = "See README.md file."

  s.files = Dir["{app,config,db,lib}/**/*"] +
    ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "> 3.2"

  s.add_development_dependency "sqlite3"
end
