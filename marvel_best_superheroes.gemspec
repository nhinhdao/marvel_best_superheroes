
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "marvel_best_superheroes/version"
# require_relative './lib/marvel_best_superheroes/version'

Gem::Specification.new do |spec|
    spec.name          = "marvel_best_superheroes"
    spec.version       = MarvelBestSuperheroes::VERSION
    spec.date          = "2018-07-13"
    spec.authors       = ["Nhinh Dao"]
    spec.email         = ["nhinhdao.vn@gmail.com"]

    spec.summary       = "Top 100 Marvel Best Superheroes"
    spec.description   = "Provide details on the top 100 Marvel Best Superheroes of all time"
    spec.homepage      = "http://rubygems.org/gems/marvel_best_superheroes"
    spec.license       = "MIT"


    # Specify which files should be added to the gem when it is released.
    # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
    # spec.files         = ["lib/marvel_best_superheroes/allSuperheroes.rb",
    #                         "lib/marvel_best_superheroes/superhero.rb",
    #                         "lib/marvel_best_superheroes/cli.rb",
    #                         "lib/marvel_best_superheroes.rb"]
    #                         "config/environment.rb"]
    spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
        `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
    end
    # spec.bindir        = "exe"
    # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
    spec.executables << 'marvel_best_superheroes'
    spec.require_paths = ["lib"]

    spec.add_development_dependency "bundler", "~> 1.16"
    spec.add_development_dependency "rake", "~> 10.0"
    spec.add_development_dependency "rspec", "~> 3.0"
    spec.add_development_dependency "nokogiri", ">= 0"
    spec.add_development_dependency "pry", ">= 0"
    spec.add_development_dependency "colorize", ">= 0"

end
