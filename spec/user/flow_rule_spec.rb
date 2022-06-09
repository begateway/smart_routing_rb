require 'shared_examples/responses'

RSpec.describe SmartRouting::User::FlowRule do
  let(:flow_rule) { described_class.new(user_client, flow_id: flow_id) }
  let(:data_attrs) { %i[id alias active priority description conditions objects weights handing_out_method created_at updated_at account_id] }
  let(:error_keys) { %i[code message friendly_message help errors] }
  let(:flow_id) { 'ba5519ab-2864-4914-bcd1-11c138607393' }
  let(:object_id) { '54a8b3c0-2b59-4d5d-b9a6-329dc7a78f90' }

  context '.create' do
    let(:url) { SmartRouting.api_host + "/api/user/flows/#{flow_id}/rules" }
    let(:request_params) do
      {
        alias: 'bin_country', active: true, priority: 5,
        description: 'if bin_country == UK than return EU_GATEWAY',
        conditions: [{'field' => 'bin_country', 'operation' => 'equal', 'value' => 'UK'}],
        objects: [object_id], handing_out_method: 'weight',
        weights: {object_id => 10}
      }
    end
    let(:http_status) { 201 }

    subject { flow_rule.create(request_params) }

    context 'when params are valid' do
      before do
        stub_request(:post, url).with(body: { rule: request_params }.to_json)
          .to_return(status: http_status, body: UserResponseFixtures.successful_creation_rule_response)
      end

      it_behaves_like 'successful response'
    end

    context 'when params are invalid' do
      let(:request_params) { {} }
      let(:http_status) { 422 }

      before do
        stub_request(:post, url).with(body: { rule: request_params }.to_json)
          .to_return(status: http_status, body: UserResponseFixtures.failed_creation_rule_response)
      end

      it_behaves_like 'error response'
    end
  end

  context '.update' do
    let(:id) { 'abac3693-3758-4039-a91a-c4157d931814' }
    let(:url) { SmartRouting.api_host + "/api/user/flows/#{flow_id}/rules/#{id}" }
    let(:request_params) { {alias: 'bin_country_uk'} }
    let(:http_status) { 200 }

    subject { flow_rule.update(id, request_params) }

    context 'when params are valid' do
      before do
        stub_request(:put, url).with(body: { rule: request_params }.to_json)
          .to_return(status: http_status, body: UserResponseFixtures.successful_update_rule_response)
      end

      it_behaves_like 'successful response'
    end

    context 'when params are invalid' do
      let(:request_params) { {} }
      let(:http_status) { 422 }

      before do
        stub_request(:put, url).with(body: { rule: request_params }.to_json)
          .to_return(status: http_status, body: UserResponseFixtures.failed_update_rule_response)
      end

      it_behaves_like 'error response'
    end
  end

  context '.get' do
    let(:id) { 'abac3693-3758-4039-a91a-c4157d931814' }
    let(:url) { SmartRouting.api_host + "/api/user/flows/#{flow_id}/rules/#{id}" }
    let(:http_status) { 200 }

    subject { flow_rule.get(id) }

    before do
      stub_request(:get, url)
        .to_return(status: http_status, body: UserResponseFixtures.successful_get_rule_response)
    end

    it_behaves_like 'successful response'
  end

  context '.all' do
    let(:url) { SmartRouting.api_host + "/api/user/flows/#{flow_id}/rules" }
    let(:http_status) { 200 }

    subject { flow_rule.all }

    before do
      stub_request(:get, url)
        .to_return(status: http_status, body: UserResponseFixtures.successful_all_rule_response)
    end

    it_behaves_like 'successful items response'
  end

  context '.delete' do
    let(:id) { 'abac3693-3758-4039-a91a-c4157d931814' }
    let(:url) { SmartRouting.api_host + "/api/user/flows/#{flow_id}/rules/#{id}" }
    let(:http_status) { 204 }

    subject { flow_rule.delete(id) }

    before do
      stub_request(:delete, url)
        .to_return(status: http_status, body: nil)
    end

    it 'returns successful response' do
      expect(subject.status).to be 204

      expect(subject.success?).to be true
      expect(subject.error?).to be false

      expect(subject.data.object).to be nil
    end
  end
end
