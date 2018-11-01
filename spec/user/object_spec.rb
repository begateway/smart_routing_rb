require "shared_examples/responses"

RSpec.describe SmartRouting::User::Object do
  let(:object) { described_class.new(user_client) }
  let(:data_attrs) { %i(id name type_id output_value created_at updated_at account_id) }
  let(:error_keys) { %i(code message friendly_message help errors) }

  context ".create" do
    let(:url) { SmartRouting.api_host + "/api/user/objects" }
    let(:request_params) { {name: "gw_UK", type_id: "02c07bce-3a10-418e-9d77-d2c57c9bc71c", output_value: "1288"} }
    let(:http_status) { 201 }

    subject { object.create(request_params) }

    context "when params are valid" do
      before do
        stub_request(:post, url).with(body: {object: request_params}.to_json).
          to_return(status: http_status, body: UserResponseFixtures.successful_creation_object_response)
      end

      it_behaves_like "successful response"
    end

    context "when params are invalid" do
      let(:request_params) { {} }
      let(:http_status) { 422 }

      before do
        stub_request(:post, url).with(body: {object: request_params}.to_json).
          to_return(status: http_status, body: UserResponseFixtures.failed_creation_object_response)
      end

      it_behaves_like "error response"
    end
  end

  context ".update" do
    let(:id) { "54a8b3c0-2b59-4d5d-b9a6-329dc7a78f90" }
    let(:url) { SmartRouting.api_host + "/api/user/objects/#{id}" }
    let(:request_params) { {name: "gw_BY", output_value: "1599"} }
    let(:http_status) { 200 }

    subject { object.update(id, request_params) }

    context "when params are valid" do
      before do
        stub_request(:put, url).with(body: {object: request_params}.to_json).
          to_return(status: http_status, body: UserResponseFixtures.successful_update_object_response)
      end

      it_behaves_like "successful response"
    end

    context "when params are invalid" do
      let(:request_params) { {} }
      let(:http_status) { 422 }

      before do
        stub_request(:put, url).with(body: {object: request_params}.to_json).
          to_return(status: http_status, body: UserResponseFixtures.failed_update_object_response)
      end

      it_behaves_like "error response"
    end
  end

  context ".get" do
    let(:id) { "54a8b3c0-2b59-4d5d-b9a6-329dc7a78f90" }
    let(:url) { SmartRouting.api_host + "/api/user/objects/#{id}" }
    let(:http_status) { 200 }

    subject { object.get(id) }

    before do
      stub_request(:get, url).
        to_return(status: http_status, body: UserResponseFixtures.successful_get_object_response)
    end

    it_behaves_like "successful response"
  end

  context ".all" do
    let(:url) { SmartRouting.api_host + "/api/user/objects" }
    let(:http_status) { 200 }

    subject { object.all }

    before do
      stub_request(:get, url).
        to_return(status: http_status, body: UserResponseFixtures.successful_all_object_response)
    end

    it_behaves_like "successful items response"
  end

end
