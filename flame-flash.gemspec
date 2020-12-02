# frozen_string_literal: true

Gem::Specification.new do |spec|
	spec.name        = 'flame-flash'
	spec.version     = '3.0.0'

	spec.summary     = 'Flash plugin for Flame-framework'

	spec.description = <<~TEXT
		Show messages (notifies, errors, warnings) in current or next routes after redirect.
	TEXT

	spec.authors     = ['Alexander Popov']
	spec.email       = ['alex.wayfer@gmail.com']
	spec.license     = 'MIT'

	source_code_uri = 'https://github.com/AlexWayfer/flame-flash'

	spec.homepage = source_code_uri

	spec.metadata['source_code_uri'] = source_code_uri

	spec.metadata['homepage_uri'] = spec.homepage

	spec.metadata['changelog_uri'] =
		'https://github.com/AlexWayfer/flame-flash/blob/master/CHANGELOG.md'

	spec.files = Dir['lib/**/*.rb', 'README.md', 'LICENSE.txt', 'CHANGELOG.md']

	spec.required_ruby_version = '~> 2.5'

	spec.add_runtime_dependency 'flame', '>= 5.0.0.rc3', '< 6'
	spec.add_runtime_dependency 'gorilla_patch', '>= 1', '< 5'

	spec.add_development_dependency 'pry-byebug', '~> 3.9'

	spec.add_development_dependency 'bundler', '~> 2.0'
	spec.add_development_dependency 'gem_toys', '~> 0.3.0'
	spec.add_development_dependency 'toys', '~> 0.10.4'

	spec.add_development_dependency 'codecov', '~> 0.2.0'
	spec.add_development_dependency 'rack-test', '~> 1.0'
	spec.add_development_dependency 'rspec', '~> 3.9'
	spec.add_development_dependency 'simplecov', '~> 0.18.0'

	spec.add_development_dependency 'rubocop', '~> 1.4.2'
	spec.add_development_dependency 'rubocop-performance', '~> 1.0'
	spec.add_development_dependency 'rubocop-rspec', '~> 1.0'
end
