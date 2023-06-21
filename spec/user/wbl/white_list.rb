require "shared_examples/responses"

RSpec.describe SmartRouting::User::Wbl::WhiteLists do
  let(:object) { described_class.new(user_client) }
  let(:data_attrs) { %i(type attribute) }

  describe '.modify' do
    let(:url) { SmartRouting.api_host + '/api/user/white-list' }
    let(:request_params) { { list: { type: 'ip', value: '14.14.14.14', mode: 'append' } } }
    let(:http_status) { 204 }
    let(:error_keys) { %i(code message friendly_message help errors) }

    subject { object.modify(request_params) }

    context 'when params are valid' do
      before do
        stub_request(:post, url).with(body: (request_params).to_json).
          to_return(status: http_status, body: nil)
      end

      it 'returns successful responses' do
        expect(subject.status).to be http_status

        expect(subject.success?).to be true
        expect(subject.error?).to be false
      end
    end

    context 'when params are invalid' do
      let(:request_params) { {list: { type: 'wrong' }} }
      let(:http_status) { 422 }

      before do
        stub_request(:post, url).with(body: (request_params).to_json).
          to_return(status: http_status, body: UserResponseFixtures.failed_adding_data_to_wb_list)
      end

      it_behaves_like 'error response'
    end
  end

  describe '.delete' do
    let(:url) { SmartRouting.api_host + '/api/user/white-list' }

    subject { object.delete(request_params) }

    context 'when params are valid' do
      let(:request_params) { { list: { type: 'ip', value: '14.14.14.14' } } }
      let(:http_status) { 204 }

      before do
        stub_request(:delete, url).with(query: request_params).
          to_return(status: http_status, body: nil)
      end

      it 'returns successful responses' do
        expect(subject.status).to be http_status

        expect(subject.success?).to be true
        expect(subject.error?).to be false
      end
    end

    context 'when params are invalid' do
      let(:request_params) { { list: { type: 'ip' } } }
      let(:http_status) { 422 }
      let(:error_keys) { %i(code message friendly_message help) } 

      before do
        stub_request(:delete, url).with(query: request_params).
          to_return(status: http_status, body: UserResponseFixtures.failed_deleting_value_from_wb_list)
      end

      it_behaves_like 'error response'
    end
  end
end
