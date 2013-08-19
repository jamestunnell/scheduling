# -*- encoding: utf-8 -*-

require File.expand_path('../lib/scheduling/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "scheduling"
  gem.version       = Scheduling::VERSION
  gem.summary       = %q{Make schedules, regular (yearly, monthly, etc.) or otherwise.}
  gem.description   = %q{Classes for making schedules, that are regular (yearly, monthly, etc.), irregular, or both (compound). Once a schedule is made, and given a target date range, the date of all occurances can be determined. }
  gem.license       = "MIT"
  gem.authors       = ["James Tunnell"]
  gem.email         = "jamestunnell@gmail.com"
  gem.homepage      = "https://rubygems.org/gems/scheduling"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'rake', '~> 0.8'
  gem.add_development_dependency 'rspec', '~> 2.4'
  gem.add_development_dependency 'yard', '~> 0.8'
  gem.add_development_dependency 'pry'
end
