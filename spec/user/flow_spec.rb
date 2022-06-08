require 'shared_examples/responses'

RSpec.describe SmartRouting::User::Flow do
  let(:flow) { described_class.new(user_client) }
  let(:data_attrs) { %i[type system rule_processing_order priority name id description active account_id] }
  let(:error_keys) { %i[code message friendly_message help errors] }
  let(:id) { 'ba5519ab-2864-4914-bcd1-11c138607393' }

  context '.create' do
    let(:url) { SmartRouting.api_host + '/api/user/flows' }
    let(:request_params) do
      {
        type: 'object',
        system: false,
        rule_processing_order: 'random',
        'priority': 220,
        'name': 'Test flow',
        'description': 'Something about flow',
        'active': true
      }
    end
    let(:http_status) { 201 }

    subject { flow.create(request_params) }

    context 'when params are valid' do
      before do
        stub_request(:post, url).with(body: { flow: request_params }.to_json)
          .to_return(status: http_status, body: UserResponseFixtures.successful_creation_flow_response)
      end

      it_behaves_like 'successful response'
    end

    context 'when params are invalid' do
      let(:request_params) { {} }
      let(:http_status) { 422 }

      before do
        stub_request(:post, url).with(body: { flow: request_params }.to_json)
          .to_return(status: http_status, body: UserResponseFixtures.failed_creation_flow_response)
      end

      it_behaves_like 'error response'
    end
  end

  context '.update' do
    let(:id) { 'abac3693-3758-4039-a91a-c4157d931814' }
    let(:url) { SmartRouting.api_host + "/api/user/flows/#{id}" }
    let(:request_params) { { priority: 200 } }
    let(:http_status) { 200 }

    subject { flow.update(id, request_params) }

    context 'when params are valid' do
      before do
        stub_request(:put, url).with(body: { flow: request_params }.to_json)
          .to_return(status: http_status, body: UserResponseFixtures.successful_update_flow_response)
      end

      it_behaves_like 'successful response'
    end

    context 'when params are invalid' do
      let(:request_params) { {} }
      let(:http_status) { 422 }

      before do
        stub_request(:put, url).with(body: { flow: request_params }.to_json)
          .to_return(status: http_status, body: UserResponseFixtures.failed_update_flow_response)
      end

      it_behaves_like 'error response'
    end
  end

  context '.get' do
    let(:id) { 'abac3693-3758-4039-a91a-c4157d931814' }
    let(:url) { SmartRouting.api_host + "/api/user/flows/#{id}" }
    let(:http_status) { 200 }

    subject { flow.get(id) }

    before do
      stub_request(:get, url)
        .to_return(status: http_status, body: UserResponseFixtures.successful_get_flow_response)
    end

    it_behaves_like 'successful response'
  end

  context '.all' do
    let(:url) { SmartRouting.api_host + '/api/user/flows' }
    let(:http_status) { 200 }

    subject { flow.all }

    before do
      stub_request(:get, url)
        .to_return(status: http_status, body: UserResponseFixtures.successful_all_flow_response)
    end

    it_behaves_like 'successful items response'
  end

  context '.delete' do
    let(:url) { SmartRouting.api_host + "/api/user/flows/#{id}" }
    let(:http_status) { 204 }

    subject { flow.delete(id) }

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

  context '.verify' do
    let(:url) { SmartRouting.api_host + '/api/user/flows/verify' }
    let(:params) { { fields: { bin_country: 'UK' }, allowable_return_values: ['1'] }}

    subject { flow.verify(params) }

    context 'when params are valid and flow matched' do
      before do
        stub_request(:post, url).with(body: { data: params }.to_json)
          .to_return(status: 200, body: UserResponseFixtures.successful_verify_flows_matched_response)
      end

      it 'returns successful response' do
        expect(subject.status).to be 200

        expect(subject.success?).to be true
        expect(subject.error?).to be false

        expect(subject.data.to_h.keys).to contain_exactly *%i[action_rules object object_defined_via object_name object_rules status]

        expect(subject.data.object).to eq('1245')
        expect(subject.data.object_rules.count).to eq 1

        rule = subject.data.object_rules.first
        expect(rule.keys).to eq(%w[state description alias])
        expect(rule['state']).to eq('matched')
      end
    end

    context 'when params are valid add flow not matched' do
      before do
        stub_request(:post, url).with(body: { data: params }.to_json)
          .to_return(status: 200, body: UserResponseFixtures.successful_verify_flows_not_matched_response)
      end

      it 'returns successful response' do
        expect(subject.status).to be 200

        expect(subject.success?).to be true
        expect(subject.error?).to be false

        expect(subject.data.to_h.keys).to contain_exactly *%i[action_rules object object_defined_via object_name object_rules status]

        expect(subject.data.object).to eq('1245')
        expect(subject.data.object_rules.count).to eq 1

        rule = subject.data.object_rules.first
        expect(rule.keys).to eq(%w[state description alias])
        expect(rule['state']).to eq 'not_matched'
      end
    end

    context 'when params are invalid' do
      let(:params) {{ fields: {bin_country: nil}, allowable_return_values: ['1']}}

      before do
        stub_request(:post, url).with(body: {data: params}.to_json)
          .to_return(status: 422, body: UserResponseFixtures.failed_verify_rules_response)
      end

      it 'returns error response' do
        expect(subject.status).to be 422

        expect(subject.success?).to be false
        expect(subject.error?).to be true

        expect(subject.error.to_h.keys).to contain_exactly *%i(code message friendly_message help errors)

        expect(subject.error.code).to eq('validation_error')
        expect(subject.error.message).to eq('Parameters are invalid')
        expect(subject.error.friendly_message).to eq('Bin_country must be string.')
        expect(subject.error.help).to eq('https://doc.begateway.com/codes/validation_error')
        expect(subject.error.errors).to eq('bin_country' => ['must be string'])
      end
    end
  end
end
