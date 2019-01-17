require "shared_examples/responses"

RSpec.describe SmartRouting::User::ObjectType do
  let(:object_type) { described_class.new(user_client) }
  let(:data_attrs)  { %i(id name created_at updated_at account_id) }
  let(:error_keys)  { %i(code message friendly_message help errors) }

  context ".create" do
    let(:url) { SmartRouting.api_host + "/api/user/object-types" }
    let(:request_params) { {name: "gw_EU"} }
    let(:http_status) { 201 }

    subject { object_type.create(request_params) }

    context "when params are valid" do
      before do
        stub_request(:post, url).with(body: {object_type: request_params}.to_json).
          to_return(status: http_status, body: UserResponseFixtures.successful_creation_object_type_response)
      end

      it_behaves_like "successful response"
    end

    context "when params are invalid" do
      let(:request_params) { {name: nil} }
      let(:http_status) { 422 }

      before do
        stub_request(:post, url).with(body: {object_type: request_params}.to_json).
          to_return(status: http_status, body: UserResponseFixtures.failed_creation_object_type_response)
      end

      it_behaves_like "error response"
    end
  end

  context ".update" do
    let(:id) { "10429c03-a343-4b24-9b03-7e1c360f7467" }
    let(:url) { SmartRouting.api_host + "/api/user/object-types/#{id}" }
    let(:request_params) { {name: "gw_Europe"} }
    let(:http_status) { 200 }

    subject { object_type.update(id, request_params) }

    context "when params are valid" do
      before do
        stub_request(:put, url).with(body: {object_type: request_params}.to_json).
          to_return(status: http_status, body: UserResponseFixtures.successful_update_object_type_response)
      end

      it_behaves_like "successful response"
    end

    context "when params are invalid" do
      let(:request_params) { {} }
      let(:http_status) { 422 }

      before do
        stub_request(:put, url).with(body: {object_type: request_params}.to_json).
          to_return(status: http_status, body: UserResponseFixtures.failed_update_object_type_response)
      end

      it_behaves_like "error response"
    end
  end

  context ".get" do
    let(:id) { "10429c03-a343-4b24-9b03-7e1c360f7467" }
    let(:url) { SmartRouting.api_host + "/api/user/object-types/#{id}" }
    let(:http_status) { 200 }

    subject { object_type.get(id) }

    before do
      stub_request(:get, url).
        to_return(status: http_status, body: UserResponseFixtures.successful_get_object_type_response)
    end

    it_behaves_like "successful response"
  end

  context ".all" do
    let(:url) { SmartRouting.api_host + "/api/user/object-types" }
    let(:http_status) { 200 }

    subject { object_type.all }

    before do
      stub_request(:get, url).
        to_return(status: http_status, body: UserResponseFixtures.successful_all_object_type_response)
    end

    it_behaves_like "successful items response"
  end

end
