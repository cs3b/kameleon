Gem::Specification.new do |s|
  s.name = 'kameleon'
  s.version = '0.0.1.pre'
  s.files = Dir['lib/**/*.rb'] + Dir['spec/**/*.rb'] + ['LICENCE']
  s.add_runtime_dependency 'capybara, rspec'
  s.add_development_dependency 'rspec'
  s.summary = "high abstraction dsl for end user perspective tests"
  s.description = "kameleon - it's a polish word for chameleon"
  s.authors = ["Michał Czyż [@cs3b]"]
  s.email = 'michalczyz@gmail.com'
  s.homepage = 'http://kameleon.cs3b.com'

  s.license = 'MIT'
end
