# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.name          = "icing"
  gem.version       = '0.0.1'
  gem.authors       = ["Jesse Stuart"]
  gem.email         = ["jesse@jessestuart.ca"]
  gem.description   = %q{Custom Bootstrap for Tent apps}
  gem.summary       = %q{Custom Bootstrap for Tent apps}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'sprockets', '~> 2.0'
  gem.add_runtime_dependency 'sprockets-helpers', '~> 0.2'
  gem.add_runtime_dependency 'sprockets-sass',    '~> 0.5'
  gem.add_runtime_dependency 'compass', '~> 0.12.2'
  gem.add_runtime_dependency 'sass'
end
