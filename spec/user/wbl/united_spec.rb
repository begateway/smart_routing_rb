require "shared_examples/responses"

RSpec.describe SmartRouting::User::Wbl::United do
  let(:object) { described_class.new(user_client) }
  let(:data_attrs) { %i(type attribute) }

  context ".exists" do
    let(:url) { SmartRouting.api_host + "/api/user/white-black-list/exists" }
    let(:request_params) { { list: { type: 'ip', value: '12.12.12.12' } } }
    let(:http_status) { 200 }

    subject { object.exists(request_params) }

    context "when params are valid" do
      before do
        stub_request(:get, url).with(query: request_params).
          to_return(status: http_status, body: UserResponseFixtures.value_exists_in_wbl)
      end

      it_behaves_like "successful items response"
    end

    context "when params are invalid" do
      let(:request_params) { {list: { type: 'ip', value: '123456XXXX1234' }} }
      let(:http_status) { 200 }

      before do
        stub_request(:get, url).with(query: request_params).
          to_return(status: http_status, body: UserResponseFixtures.value_does_not_exists_in_wbl)
      end

      it 'returns successful status' do
        expect(subject.success?).to be true
        expect(subject.error?).to be false
      end

      it 'returns empty array in data' do
        expect(subject.data).to eq []
      end
    end
  end
end
