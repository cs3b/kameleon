Gem::Specification.new do |s|
  s.name = 'kameleon'
  s.version = '0.2.0.alpha.2'
  s.files = Dir['lib/**/*.rb'] + %w(LICENCE README.textile)
  s.add_runtime_dependency 'rspec'
  s.add_runtime_dependency 'capybara'
  s.add_runtime_dependency 'headless'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'headless'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'capybara-webkit'
  s.summary = "high abstraction dsl for end user perspective tests"
  s.description = "high abstraction dsl for end user perspective tests, kameleon - it's a polish word for chameleon"
  s.authors = ["Michał Czyż [cs3b]", "Radosław Jędryszczak [socjopata]", "Szymon Kieloch [Skieloch]"]
  s.email = 'michalczyz@gmail.com'
  s.homepage = 'https://github.com/cs3b/kameleon'

  s.license = 'MIT'
end
