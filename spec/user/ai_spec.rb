require "shared_examples/responses"

RSpec.describe SmartRouting::User::AI do
  let(:ai) { described_class.new(user_client) }

  context ".verify" do
    let(:url) { SmartRouting.api_host + "/api/user/ai/verify" }
    let(:params) {{ fields: {bin_country: "UK"}, allowable_return_values: ['1'], options: {} }}

    subject { ai.verify(params) }

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
      let(:params) {{ fields: {bin_country: nil}, allowable_return_values: ['1'], options: {}}}

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

    context "only specific keys in the request data" do
      let(:params) do
        { 
          fields: {bin_country: nil},
          allowable_return_values: ['1'],
          options: { verify_only: ["action_rules"] },
          some_bad_key: "bad data"
        }
      end

      it "data contains only fields, allowable_return_values and options keys" do
        expect_any_instance_of(SmartRouting::Connection).to receive(:request)
          .with(:post, "/api/user/ai/verify",
            { data:
              {
                fields: {bin_country: nil},
                allowable_return_values: ['1'],
                options: { verify_only: ["action_rules"]}
              }
            }).and_return(status: 200, body: UserResponseFixtures.successful_verify_rules_matched_response)

        subject { ai.verify(params) }
      end
    end
  end
end
