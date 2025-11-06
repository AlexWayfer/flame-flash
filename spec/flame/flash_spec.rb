# frozen_string_literal: true

describe Flame::Flash do
	require 'rack/test'
	include Rack::Test::Methods

	subject { last_response.body }

	let(:controller_class) do
		Class.new(Flame::Controller) do
			include Flame::Flash

			private

			def server_error(exception)
				# p exception
				# puts exception.backtrace
			end

			def convert_flashes_to_string(flashes)
				"[#{flashes.to_a.map { |hash| convert_hash_to_string(hash) }.join(', ')}]"
			end

			def convert_hash_to_string(hash)
				"{#{hash.map { |key, value| "#{key.inspect}=>#{value.inspect}" }.join(', ')}}"
			end
		end
	end

	let(:main_controller_class) do
		Class.new(controller_class) do
			def index
				"params: #{convert_hash_to_string(params)}, " \
					"flashes: #{convert_flashes_to_string(flash.now)}"
			end

			def show(id)
				"id: #{id}, flashes: #{convert_flashes_to_string(flash.now)}"
			end

			def redirect_set_as_regular
				flash[:error] = 'Regular'
				redirect :index
			end

			def redirect_set_as_argument
				redirect :index, notice: 'Argument', **params
			end

			def redirect_set_as_argument_with_parameters
				redirect :show, id: 2, notice: 'Argument'
			end

			def redirect_set_as_argument_with_params
				redirect :index, foo: 'bar', notice: 'Argument'
			end

			def redirect_set_as_argument_for_string
				redirect '/', notice: 'Argument'
			end

			def redirect_set_as_flash_key
				redirect :index, flash: { foo: 'bar' }
			end

			def view_set_as_regular
				flash.now[:error] = 'Regular'
				view :index
			end

			def view_by_specific_type
				flash.now[:notice] = 'Hello'
				flash.now[:error] = 'Wrong!'
				flash.now[:warning] = 'Careful'
				view :by_type, type: :error
			end

			def view_set_as_argument
				view :index, notice: 'Argument'
			end

			def view_set_as_array_argument
				view :index, notice: ['One argument', 'Another argument']
			end

			def view_set_as_flash_key
				view :index, flash: { foo: 'bar' }
			end

			def view_without_parameters
				view
			end

			def halt_with_flashes
				halt redirect :index, notice: 'Halted'
			end

			protected

			def execute(action)
				flash.now.delete :notice, 'Argument' if params[:delete]
				super
			end
		end
	end

	let(:controller_with_parameter_class) do
		Class.new(controller_class) do
			def index
				"params: #{convert_hash_to_string(params)}, " \
					"flashes: #{convert_flashes_to_string(flash.now)}"
			end

			def redirect_set_as_argument
				redirect :index, foo: 'bar', notice: 'Argument'
			end
		end
	end

	let(:app) do
		main_controller_class = self.main_controller_class
		controller_with_parameter_class = self.controller_with_parameter_class

		Class.new(Flame::Application) do
			mount main_controller_class, '/'
			mount controller_with_parameter_class, '/controller_with_parameter/:?foo'
		end
	end

	before do
		stub_const 'MainTestController', main_controller_class
		stub_const 'ControllerWithParameter', controller_with_parameter_class

		get path
	end

	describe '#execute' do
		before do
			follow_redirect!
		end

		let(:path) { '/redirect_set_as_regular' }
		let(:expected_body) do
			'params: {}, flashes: [{:type=>:error, :text=>"Regular"}]'
		end

		it { is_expected.to eq expected_body }
	end

	describe '#redirect' do
		before do
			follow_redirect!
		end

		context 'without parameters for action' do
			let(:path) { '/redirect_set_as_argument' }
			let(:expected_body) do
				'params: {}, flashes: [{:type=>:notice, :text=>"Argument"}]'
			end

			it { is_expected.to eq expected_body }
		end

		context 'with parameters for action' do
			let(:path) { '/redirect_set_as_argument_with_parameters' }
			let(:expected_body) do
				'id: 2, flashes: [{:type=>:notice, :text=>"Argument"}]'
			end

			it { is_expected.to eq expected_body }
		end

		context 'with parameters for controllers' do
			let(:path) { '/controller_with_parameter/redirect_set_as_argument' }
			let(:expected_body) do
				'params: {:foo=>"bar"}, flashes: [{:type=>:notice, :text=>"Argument"}]'
			end

			it { is_expected.to eq expected_body }
		end

		context 'with params' do
			let(:path) { '/redirect_set_as_argument_with_params' }
			let(:expected_body) do
				'params: {:foo=>"bar"}, flashes: [{:type=>:notice, :text=>"Argument"}]'
			end

			it { is_expected.to eq expected_body }
		end

		context 'when first argument is a String' do
			let(:path) { '/redirect_set_as_argument_for_string' }
			let(:expected_body) do
				'params: {}, flashes: [{:type=>:notice, :text=>"Argument"}]'
			end

			it { is_expected.to eq expected_body }
		end

		context 'with flashes at `flash` key' do
			let(:path) { '/redirect_set_as_flash_key' }
			let(:expected_body) do
				'params: {}, flashes: [{:type=>:foo, :text=>"bar"}]'
			end

			it { is_expected.to eq expected_body }
		end
	end

	describe '#view' do
		shared_examples 'a successful response' do
			describe 'status of last_response' do
				subject { last_response.status }

				it { is_expected.to eq 200 }
			end
		end

		context 'with writing current flashes as regular' do
			let(:path) { '/view_set_as_regular' }
			let(:expected_body) { '[{:type=>:error, :text=>"Regular"}]' }

			it { is_expected.to eq expected_body }

			it_behaves_like 'a successful response'
		end

		describe 'view by specific type' do
			let(:path) { '/view_by_specific_type' }
			let(:expected_body) { '["Wrong!"]' }

			it { is_expected.to eq expected_body }

			it_behaves_like 'a successful response'
		end

		context 'with flashes in Hash argument' do
			let(:path) { '/view_set_as_argument' }
			let(:expected_body) { '[{:type=>:notice, :text=>"Argument"}]' }

			it { is_expected.to eq expected_body }

			it_behaves_like 'a successful response'
		end

		context 'with flashes as Array in Hash argument' do
			let(:path) { '/view_set_as_array_argument' }
			let(:expected_body) do
				'[{:type=>:notice, :text=>"One argument"}, {:type=>:notice, :text=>"Another argument"}]'
			end

			it { is_expected.to eq expected_body }

			it_behaves_like 'a successful response'
		end

		context 'with flashes in Hash at `flash` key' do
			let(:path) { '/view_set_as_flash_key' }
			let(:expected_body) { '[{:type=>:foo, :text=>"bar"}]' }

			it { is_expected.to eq expected_body }

			it_behaves_like 'a successful response'
		end

		describe '`Flame::Controller#view` without parameters' do
			let(:path) { '/view_without_parameters' }
			let(:expected_body) { "I'm still alive!\n" }

			it { is_expected.to eq expected_body }

			it_behaves_like 'a successful response'
		end
	end

	describe '#halt' do
		before do
			follow_redirect!
		end

		let(:path) { '/halt_with_flashes' }
		let(:expected_body) do
			'params: {}, flashes: [{:type=>:notice, :text=>"Halted"}]'
		end

		it { is_expected.to eq expected_body }
	end

	describe 'flash.now.delete' do
		before do
			follow_redirect!
		end

		let(:path) { '/redirect_set_as_argument?delete=true' }
		let(:expected_body) do
			'params: {:delete=>"true"}, flashes: []'
		end

		it { is_expected.to eq expected_body }
	end
end
