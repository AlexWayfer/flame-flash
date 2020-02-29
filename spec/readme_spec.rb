# frozen_string_literal: true

describe 'README' do
	subject(:readme) { File.read File.join(__dir__, '..', 'README.md') }

	it 'includes reserved flash keys' do
		expect(readme).to include(
			*Flame::Flash::RESERVED_FLASH_KEYS.map { |key| "*   `#{key}`" }
		)
	end
end
