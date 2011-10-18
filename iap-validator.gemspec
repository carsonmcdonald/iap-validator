# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "iap-validator/version"

Gem::Specification.new do |s|
  s.name        = "iap-validator"
  s.version     = IAPValidator::VERSION
  s.authors     = ["Carson McDonald"]
  s.email       = ["carson@ioncannon.net"]
  s.homepage    = "http://github.com/carsonmcdonald/iap-validator"
  s.license     = "MIT"
  s.summary     = %Q{Apple iTunes in app purchase receipt validator}
  s.description = %Q{This gem will validate base64 encoded receipts from iTunes in app purchases.}

  s.rubyforge_project = "iap-validator"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "httparty"
end
