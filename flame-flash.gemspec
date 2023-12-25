# frozen_string_literal: true

require_relative 'lib/flame/flash/version'

Gem::Specification.new do |spec|
	spec.name        = 'flame-flash'
	spec.version     = Flame::Flash::VERSION

	spec.summary     = 'Flash plugin for Flame-framework'

	spec.description = <<~TEXT
		Show messages (notifies, errors, warnings) in current or next routes after redirect.
	TEXT

	spec.authors     = ['Alexander Popov']
	spec.email       = ['alex.wayfer@gmail.com']
	spec.license     = 'MIT'

	github_uri = "https://github.com/AlexWayfer/#{spec.name}"

	spec.homepage = github_uri

	spec.metadata = {
		'bug_tracker_uri' => "#{github_uri}/issues",
		'changelog_uri' => "#{github_uri}/blob/v#{spec.version}/CHANGELOG.md",
		'documentation_uri' => "http://www.rubydoc.info/gems/#{spec.name}/#{spec.version}",
		'homepage_uri' => spec.homepage,
		'rubygems_mfa_required' => 'true',
		'source_code_uri' => github_uri
		# 'wiki_uri' => "#{github_uri}/wiki"
	}

	spec.files = Dir['lib/**/*.rb', 'README.md', 'LICENSE.txt', 'CHANGELOG.md']

	spec.required_ruby_version = '>= 3.0', '< 4'

	spec.add_runtime_dependency 'flame', '>= 5.0.0.rc8', '< 6'
	spec.add_runtime_dependency 'gorilla_patch', '>= 1', '< 6'
end
