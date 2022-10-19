require "shared_examples/responses"

RSpec.describe SmartRouting::User::Rule do
  let(:rule) { described_class.new(user_client) }
  let(:data_attrs) { %i(id alias active priority description conditions objects weights handing_out_method created_at updated_at account_id) }
  let(:error_keys) { %i(code message friendly_message help errors) }
  let(:object_id) { "54a8b3c0-2b59-4d5d-b9a6-329dc7a78f90" }

  context ".create" do
    let(:url) { SmartRouting.api_host + "/api/user/rules" }
    let(:request_params) do
      {
        alias: "bin_country", active: true, priority: 5,
        description: "if bin_country == UK than return EU_GATEWAY",
        conditions: [{"field" => "bin_country", "operation" => "equal", "value" => "UK"}],
        objects: [object_id], handing_out_method: "weight",
        weights: {object_id => 10}
      }
    end
    let(:http_status) { 201 }

    subject { rule.create(request_params) }

    context "when params are valid" do
      before do
        stub_request(:post, url).with(body: {rule: request_params}.to_json).
          to_return(status: http_status, body: UserResponseFixtures.successful_creation_rule_response)
      end

      it_behaves_like "successful response"
    end

    context "when params are invalid" do
      let(:request_params) { {} }
      let(:http_status) { 422 }

      before do
        stub_request(:post, url).with(body: {rule: request_params}.to_json).
          to_return(status: http_status, body: UserResponseFixtures.failed_creation_rule_response)
      end

      it_behaves_like "error response"
    end
  end

  context ".update" do
    let(:id) { "abac3693-3758-4039-a91a-c4157d931814" }
    let(:url) { SmartRouting.api_host + "/api/user/rules/#{id}" }
    let(:request_params) { {alias: "bin_country_uk"} }
    let(:http_status) { 200 }

    subject { rule.update(id, request_params) }

    context "when params are valid" do
      before do
        stub_request(:put, url).with(body: {rule: request_params}.to_json).
          to_return(status: http_status, body: UserResponseFixtures.successful_update_rule_response)
      end

      it_behaves_like "successful response"
    end

    context "when params are invalid" do
      let(:request_params) { {} }
      let(:http_status) { 422 }

      before do
        stub_request(:put, url).with(body: {rule: request_params}.to_json).
          to_return(status: http_status, body: UserResponseFixtures.failed_update_rule_response)
      end

      it_behaves_like "error response"
    end
  end

  context ".get" do
    let(:id) { "abac3693-3758-4039-a91a-c4157d931814" }
    let(:url) { SmartRouting.api_host + "/api/user/rules/#{id}" }
    let(:http_status) { 200 }

    subject { rule.get(id) }

    before do
      stub_request(:get, url).
        to_return(status: http_status, body: UserResponseFixtures.successful_get_rule_response)
    end

    it_behaves_like "successful response"
  end

  context ".all" do
    let(:url) { SmartRouting.api_host + "/api/user/rules" }
    let(:http_status) { 200 }

    subject { rule.all }

    before do
      stub_request(:get, url).
        to_return(status: http_status, body: UserResponseFixtures.successful_all_rule_response)
    end

    it_behaves_like "successful items response"
  end

  context ".verify" do
    let(:url) { SmartRouting.api_host + "/api/user/rules/verify" }
    let(:params) {{ fields: {bin_country: "UK"}, allowable_return_values: ['1'], options: {} }}

    subject { rule.verify(params) }

    context "when params are valid and rule matched" do
      before do
        stub_request(:post, url).with(body: {data: params}.to_json).
          to_return(status: 200, body: UserResponseFixtures.successful_verify_rules_matched_response)
      end

      it "returns successful response" do
        expect(subject.status).to be 200

        expect(subject.success?).to be true
        expect(subject.error?).to be false

        expect(subject.data.to_h.keys).to contain_exactly *%i(rules object)

        expect(subject.data.object).to eq("125")
        expect(subject.data.rules.count).to eq 1

        rule = subject.data.rules.first
        expect(rule.keys).to eq(%w(state description alias))
        expect(rule["state"]).to eq("matched")
      end
    end

    context "when params are valid add rule not matched" do
      before do
        stub_request(:post, url).with(body: {data: params}.to_json).
          to_return(status: 200, body: UserResponseFixtures.successful_verify_rules_not_matched_response)
      end

      it "returns successful response" do
        expect(subject.status).to be 200

        expect(subject.success?).to be true
        expect(subject.error?).to be false

        expect(subject.data.to_h.keys).to contain_exactly *%i(rules object)

        expect(subject.data.object).to be nil
        expect(subject.data.rules.count).to eq 2

        expect(subject.data.rules.first["state"]).to eq "not_matched"
        expect(subject.data.rules.last["state"]).to eq "not_matched"
      end
    end

    context "when params are invalid" do
      let(:params) {{ fields: {bin_country: nil}, allowable_return_values: ['1'], options: {} }}

      before do
        stub_request(:post, url).with(body: {data: params}.to_json).
          to_return(status: 422, body: UserResponseFixtures.failed_verify_rules_response)
      end

      it "returns error response" do
        expect(subject.status).to be 422

        expect(subject.success?).to be false
        expect(subject.error?).to be true

        expect(subject.error.to_h.keys).to contain_exactly *%i(code message friendly_message help errors)

        expect(subject.error.code).to eq("validation_error")
        expect(subject.error.message).to eq("Parameters are invalid")
        expect(subject.error.friendly_message).to eq("Bin_country must be string.")
        expect(subject.error.help).to eq("https://doc.begateway.com/codes/validation_error")
        expect(subject.error.errors).to eq("bin_country" => ["must be string"])
      end
    end
  end

end
