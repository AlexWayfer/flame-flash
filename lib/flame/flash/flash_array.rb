# frozen_string_literal: true

module Flame
	## https://github.com/bbatsov/rubocop/issues/5831
	module Flash
		## Just contains flashes
		class FlashArray
			## Initialize Flash Array from regular Array
			## @param array [Array<Hash>] initial Array with raw data
			def initialize(array = [])
				@array = []
				concat(array)
			end

			## Go through internal Array
			def each(...)
				@array.each(...)
			end

			## Write text by type
			def push(type, text)
				if text.is_a?(Enumerable)
					text.each { |el| push(type, el) }
					return
				end
				hash = { type: type, text: text }
				@array.push(hash)
			end

			alias []= push

			## Delete text in type
			def delete(type, text)
				@array.delete(type: type, text: text)
			end

			## Select values by text or type
			def select(**options)
				@array.select do |hash|
					options.reject { |key, val| hash[key] == val || val.nil? }.empty?
				end
			end

			## Concat with other Array-like
			def concat(array)
				array.each do |hash|
					push(hash[:type], hash[:text])
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
