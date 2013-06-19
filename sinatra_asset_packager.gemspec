# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra_asset_packager/version'

Gem::Specification.new do |gem|
  gem.name          = "sinatra_asset_packager"
  gem.version       = SinatraAssetPackager::VERSION
  gem.authors       = ["scottmotte"]
  gem.email         = ["scott@scottmotte.com"]
  gem.description   = %q{Opinionated asset packaging for Sinatra done well.}
  gem.summary       = %q{Opinionated asset packaging for Sinatra done well.}
  gem.homepage      = "http://github.com/scottmotte/sinatra_asset_packager"
  
  gem.add_dependency "rake"
  gem.add_dependency "sinatra"
  gem.add_dependency "sprockets"
  gem.add_dependency "uglifier"
  gem.add_dependency "yui-compressor"
  gem.add_dependency "json", "~> 1.7.7"
  gem.add_dependency "compass"
  
  gem.add_development_dependency "pry"
  gem.add_development_dependency "rspec"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
