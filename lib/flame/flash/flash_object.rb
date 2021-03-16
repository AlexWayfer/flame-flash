# frozen_string_literal: true

require_relative 'flash_array'

module Flame
	## https://github.com/bbatsov/rubocop/issues/5831
	module Flash
		## Contains info about current and next flashes
		class FlashObject
			attr_reader :now, :next

			## Initialize Flash Object with specific session
			def initialize(session)
				@now = FlashArray.new(session.to_a)
				@next = FlashArray.new
			end

			## Add entry with type and text
			def []=(type, text)
				self.next.push type, text
			end

			## Get entries by type
			def [](type = nil)
				now.select(type: type).map { |hash| hash[:text] }
			end

			## Mass adding to next
			def merge(hash)
				hash.each { |type, text| self[type] = text }
			end
		end

		private_constant :FlashObject
	end
end
