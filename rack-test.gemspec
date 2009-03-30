Gem::Specification.new do |s|
  s.name               = "rack-test"
  s.version            = "0.0.1"
  s.date               = "2009-03-26"
  s.summary            = "Test for Rack"
  s.author             = "Luca Guidi"
  s.email              = "guidi.luca@gmail.com"
  s.homepage           = "http://lucaguidi.com"
  s.description        = "Test for Rack"
  s.has_rdoc           = true
  s.files              = ["MIT-LICENSE", "README.textile", "Rakefile", "lib/rack/test.rb", "lib/rack/unit/test_case.rb", "rack-test.gemspec", "spec/rack/unit/test_case_spec.rb", "spec/spec_helper.rb"]
  s.test_files         = ["spec/rack/unit/test_case_spec.rb"]
  s.extra_rdoc_files   = ['README.textile']
end
