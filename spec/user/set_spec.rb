require "shared_examples/responses"

RSpec.describe SmartRouting::User::Set do
  let(:set) { described_class.new(user_client) }
  let(:data_attrs)  { %i(id name value read_only created_at updated_at account_id) }

  context ".create" do
    let(:url) { SmartRouting.api_host + "/api/user/sets" }
    let(:request_params) { {name: "AllowedCountries", value: ["UK", "FR", "DE"]} }
    let(:http_status) { 201 }

    subject { set.create(request_params) }

    context "when params are valid" do
      before do
        stub_request(:post, url).with(body: {set: request_params}.to_json).
          to_return(status: http_status, body: UserResponseFixtures.successful_creation_set_response)
      end

      it_behaves_like "successful response"
    end

    context "when params are invalid" do
      let(:request_params) { {name: nil} }
      let(:http_status) { 422 }
      let(:error_keys)  { %i(code message friendly_message help errors) }

      before do
        stub_request(:post, url).with(body: {set: request_params}.to_json).
          to_return(status: http_status, body: UserResponseFixtures.failed_creation_set_response)
      end

      it_behaves_like "error response"
    end
  end

  context ".update" do
    let(:id) { "10429c03-a343-4b24-9b03-7e1c360f7467" }
    let(:url) { SmartRouting.api_host + "/api/user/sets/#{id}" }
    let(:request_params) { {value: ["UK", "FR", "DE"]} }
    let(:http_status) { 200 }

    subject { set.update(id, request_params) }

    context "when params are valid" do
      before do
        stub_request(:put, url).with(body: {set: request_params}.to_json).
          to_return(status: http_status, body: UserResponseFixtures.successful_update_set_response)
      end

      it_behaves_like "successful response"
    end

    context "when params are invalid" do
      let(:request_params) { {} }
      let(:http_status) { 422 }
      let(:error_keys)  { %i(code message friendly_message help errors) }

      before do
        stub_request(:put, url).with(body: {set: request_params}.to_json).
          to_return(status: http_status, body: UserResponseFixtures.failed_update_set_response)
      end

      it_behaves_like "error response"
    end
  end

  context ".get" do
    let(:id) { "10429c03-a343-4b24-9b03-7e1c360f7467" }
    let(:url) { SmartRouting.api_host + "/api/user/sets/#{id}" }
    let(:http_status) { 200 }

    subject { set.get(id) }

    before do
      stub_request(:get, url).
        to_return(status: http_status, body: UserResponseFixtures.successful_get_set_response)
    end

    it_behaves_like "successful response"
  end

  context ".all" do
    let(:url) { SmartRouting.api_host + "/api/user/sets" }
    let(:http_status) { 200 }

    subject { set.all }

    before do
      stub_request(:get, url).
        to_return(status: http_status, body: UserResponseFixtures.successful_all_set_response)
    end

    it_behaves_like "successful items response"
  end

end
