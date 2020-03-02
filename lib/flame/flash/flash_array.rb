# frozen_string_literal: true

module Flame
	## https://github.com/bbatsov/rubocop/issues/5831
	module Flash
		## Just contains flashes
		class FlashArray
			## Initialize Flash Array from regular Array
			def initialize(array = [])
				@array = []
				concat(array)
			end

			## Compare by with other object by internal Array
			def ==(other)
				other == @array
			end

			## Go through internal Array
			def each(&block)
				@array.each(&block)
			end

			## Write text by type into scope
			def push(type, text, scope: nil)
				if text.is_a?(Enumerable)
					text.each { |el| push(type, el, scope: scope) }
					return
				end
				hash = { type: type, text: text }
				hash[:scope] = scope if scope
				@array.push(hash)
			end

			alias []= push

			## Delete text in type
			def delete(type, text)
				@array.delete(type: type, text: text)
			end

			## Select values by text, type or scope
			def select(**options)
				@array.select do |hash|
					options.reject { |key, val| hash[key] == val || val.nil? }.empty?
				end
			end

			## Concat with other Array-like
			def concat(array)
				array.each do |hash|
					push(hash[:type], hash[:text], scope: hash[:scope])
				end
			end

			## Merge with other Hash-like
			def merge(hash)
				hash.each { |type, text| self[type] = text }
			end

			## Return internal Array
			def to_a
				@array
			end
		end

		private_constant :FlashArray
	end
end
