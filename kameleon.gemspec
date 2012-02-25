Gem::Specification.new do |s|
  s.name = 'kameleon'
  s.version = '0.0.10'
  s.files = Dir['lib/**/*.rb'] + Dir['spec/**/*.rb'] + ['LICENCE']
  s.add_runtime_dependency 'rspec'
  s.add_runtime_dependency 'capybara'
  s.add_runtime_dependency 'selenium-webdriver'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'guard-rspec'
  s.summary = "high abstraction dsl for end user perspective tests"
  s.description = "high abstraction dsl for end user perspective tests, kameleon - it's a polish word for chameleon"
  s.authors = ["Michał Czyż [cs3b]", "Radosław Jędryszczak [socjopata]", "Szymon Kieloch [Skieloch]"]
  s.email = 'michalczyz@gmail.com'
  s.homepage = 'https://github.com/cs3b/kameleon'

  s.license = 'MIT'
end
