# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

if ENV['CODECOV_TOKEN']
	require 'codecov'
	SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require 'pry-byebug'

require 'flame'
require_relative '../lib/flame/flash'
