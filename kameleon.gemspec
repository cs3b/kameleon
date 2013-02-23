# encoding: utf-8
Gem::Specification.new do |s|
  s.name = 'kameleon'

  s.required_ruby_version = ">= 1.9.0"

  s.version = '1.0.0.alpha'
  s.files = Dir['lib/**/*.rb'] + %w(LICENCE README.md)
  s.add_runtime_dependency 'rspec'
  s.add_runtime_dependency 'capybara', ["~> 2.0"]
  s.add_runtime_dependency 'headless'
  s.add_runtime_dependency 'pry'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'headless'
  s.add_development_dependency 'selenium-webdriver', ["~> 2.0"]
  s.add_development_dependency 'capybara-webkit', ["~> 1.14"]
  s.add_development_dependency 'poltergeist', ["~> 1.1"]
  s.add_development_dependency 'pry'
  s.summary = "high abstraction dsl for end user perspective tests"
  s.description = "high abstraction dsl for end user perspective tests, kameleon - it's a polish word for chameleon"
  s.authors = ["Michal Czyz [cs3b]", "Radoslaw Jedryszczak [socjopata]", "Szymon Kieloch [Skieloch]"]
  s.email = 'michalczyz@gmail.com'
  s.homepage = 'https://github.com/cs3b/kameleon'

  s.license = 'MIT'
end
