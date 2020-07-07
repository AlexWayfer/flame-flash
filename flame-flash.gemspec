# frozen_string_literal: true

require 'date'

Gem::Specification.new do |s|
	s.name        = 'flame-flash'
	s.version     = '3.0.0'
	s.date        = Date.today.to_s

	s.summary     = 'Flash plugin for Flame-framework'

	s.description = <<~TEXT
		Show messages (notifies, errors, warnings) in current or next routes after redirect.
	TEXT

	s.authors     = ['Alexander Popov']
	s.email       = ['alex.wayfer@gmail.com']
	s.homepage    = 'https://github.com/AlexWayfer/flame-flash'
	s.license     = 'MIT'

	s.required_ruby_version = '~> 2.4'

	s.add_runtime_dependency 'flame', '>= 5.0.0.rc3', '< 6'
	s.add_runtime_dependency 'gorilla_patch', '>= 1', '< 5'

	s.add_development_dependency 'codecov', '~> 0.1.0'
	s.add_development_dependency 'pry-byebug', '~> 3.6'
	s.add_development_dependency 'rack-test', '~> 1.0'
	s.add_development_dependency 'rake', '~> 13.0'
	s.add_development_dependency 'rspec', '~> 3.7'
	s.add_development_dependency 'rubocop', '~> 0.87.0'
	s.add_development_dependency 'rubocop-performance', '~> 1.5'
	s.add_development_dependency 'rubocop-rspec', '~> 1.38'
	s.add_development_dependency 'simplecov', '~> 0.18.5'

	s.files = Dir[File.join('lib', '**', '*')]
end
