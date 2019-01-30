require "shared_examples/responses"

RSpec.describe SmartRouting::User::Data do
  let(:data_obj) { described_class.new(user_client) }
  let(:error_keys) { %i(code message friendly_message help errors) }

  context ".add" do
    let(:url) { SmartRouting.api_host + "/api/user/data" }
    let(:request_params) { {created_at: "2019-01-17T09:14:21.4506Z", txn_currency: "USD", txn_amount: 150} }
    let(:http_status) { 204 }

    subject { data_obj.add(request_params) }

    context "when params are valid" do
      before do
        stub_request(:post, url).with(body: {data: request_params}.to_json).
          to_return(status: http_status, body: nil)
      end

      it "returns successful responses" do
        expect(subject.status).to be http_status

        expect(subject.success?).to be true
        expect(subject.error?).to be false
      end
    end

    context "when params are invalid" do
      let(:request_params) { {} }
      let(:http_status) { 422 }

      before do
        stub_request(:post, url).with(body: {data: request_params}.to_json).
          to_return(status: http_status, body: UserResponseFixtures.failed_adding_data_response)
      end

      it_behaves_like "error response"
    end
  end

end
