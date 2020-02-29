# frozen_string_literal: true

describe Flame::Flash::FlashObject do
	subject(:flash_object) { parent.scope(scope) }

	let(:session) { nil }
	let(:parent) { described_class.new(session) }
	let(:scope) { nil }

	describe '#now' do
		subject { super().now }

		context 'with existing session' do
			let(:session) do
				[{ type: :notice, text: 'Done' }, { type: :error, text: 'But wrong' }]
			end

			it { is_expected.to eq session }
		end

		context 'without session' do
			let(:session) { nil }

			it { is_expected.to eq [] }
		end

		context 'with Array of texts' do
			let(:session) do
				[type: :error, text: ['invalid email', 'invalid password']]
			end

			let(:expected_now) do
				[
					{ type: :error, text: 'invalid email' },
					{ type: :error, text: 'invalid password' }
				]
			end

			it { is_expected.to eq expected_now }
		end
	end

	describe '#next' do
		subject { super().next }

		it { is_expected.to eq [] }
	end

	describe '#scope' do
		let(:session) do
			[
				{ type: :error, text: 'Failed' },
				{ type: :notice, text: 'Done', scope: :one },
				{ type: :error, text: 'Failed at one', scope: :one },
				{ type: :warning, text: 'Something wrong', scope: :two }
			]
		end

		context 'without argument' do
			subject { super().scope }

			it { is_expected.to eq(flash_object) }
		end

		context 'with argument' do
			subject { super().scope(:one) }

			it { is_expected.to be_instance_of described_class }

			describe '#now' do
				subject { super().now }

				let(:expected_now) do
					[
						{ type: :notice, text: 'Done', scope: :one },
						{ type: :error, text: 'Failed at one', scope: :one }
					]
				end

				it { is_expected.to eq expected_now }
			end
		end
	end

	describe '#[]=' do
		before do
			flash_object[:error] = error
		end

		let(:error) { 'Failed' }

		context 'without scope and parent' do
			describe '#next' do
				subject { super().next }

				it { is_expected.to eq [type: :error, text: 'Failed'] }
			end
		end

		context 'with scope and parent' do
			let(:session) { [] }
			let(:scope) { :one }

			describe '#next' do
				subject { super().next }

				it { is_expected.to eq [] }
			end

			describe 'parent.next' do
				subject { parent.next }

				it { is_expected.to eq [type: :error, text: 'Failed', scope: :one] }
			end
		end

		context 'when error is Array of texts' do
			let(:error) { ['invalid email', 'invalid password'] }

			describe '#next' do
				subject { super().next }

				let(:expected_next) do
					[
						{ type: :error, text: 'invalid email' },
						{ type: :error, text: 'invalid password' }
					]
				end

				it { is_expected.to eq expected_next }
			end
		end
	end

	describe '#[]' do
		subject { super()[:error] }

		context 'without scope and parent' do
			let(:session) do
				[
					{ type: :error, text: 'invalid email' },
					{ type: :error, text: 'invalid password' },
					{ type: :notice, text: 'Done' }
				]
			end

			it { is_expected.to eq ['invalid email', 'invalid password'] }
		end

		context 'with scope and parent' do
			let(:session) do
				[
					{ type: :error, text: 'Failed' },
					{ type: :notice, text: 'Done', scope: :one },
					{ type: :error, text: 'Failed at one', scope: :one },
					{ type: :warning, text: 'Something wrong', scope: :two }
				]
			end

			let(:scope) { :one }

			it { is_expected.to eq ['Failed at one'] }
		end
	end

	describe '#merge' do
		subject { super().next }

		before do
			flash_object[:error] = 'Failed'

			flash_object.merge(notice: 'Done')
		end

		let(:expected_next) do
			[
				{ type: :error, text: 'Failed' },
				{ type: :notice, text: 'Done' }
			]
		end

		it { is_expected.to eq expected_next }
	end
end
