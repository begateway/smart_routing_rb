RSpec.describe SmartRouting::Admin::Account do
  let(:account) { described_class.new(admin_client) }

  context ".create" do
    let(:url) { SmartRouting.api_host + "/api/admin/accounts" }
    let(:params) { {name: "Shop #1"} }
    subject { account.create(params) }

    context "when params are valid" do
      before do
        stub_request(:post, url).with(body: {account: params}.to_json).
          to_return(status: 201, body: AdminResponseFixtures.successful_creation_account_response)
      end

      it "creates account and return account info" do
        expect(subject.status).to be 201

        expect(subject.success?).to be true
        expect(subject.error?).to be false

        expect(subject.data.to_h.keys).to contain_exactly *%i(id token name created_at updated_at)

        expect(subject.data.id).to eq("10429c03-a343-4b24-9b03-7e1c360f7467")
        expect(subject.data.token).to eq("9FHPid4dvvwLc1km2deoApIZshKpXvGOO1Jj4ktmyHWAvGpjicaq7ziZT7Pm3arC")
        expect(subject.data.name).to eq("Shop #1")
        expect(subject.data.created_at.to_s).to_not eq ""
        expect(subject.data.updated_at.to_s).to_not eq ""
      end
    end

    context "when params are invalid" do
      let(:params) { {name: nil} }

      before do
        stub_request(:post, url).with(body: {account: params}.to_json).
          to_return(status: 422, body: AdminResponseFixtures.failed_creation_account_response)
      end

      it "returns error response" do
        expect(subject.status).to be 422

        expect(subject.success?).to be false
        expect(subject.error?).to be true

        expect(subject.error.to_h.keys).to contain_exactly *%i(code message friendly_message help errors)

        expect(subject.error.code).to eq("validation_error")
        expect(subject.error.message).to eq("Parameters are invalid")
        expect(subject.error.friendly_message).to eq("Name can't be blank.")
        expect(subject.error.help).to eq("https://doc.ecomcharge.com/codes/validation_error")
        expect(subject.error.errors).to eq("name" => ["can't be blank"])
      end
    end
  end

  context ".update" do
    let(:id) { "10429c03-a343-4b24-9b03-7e1c360f7467" }
    let(:url) { SmartRouting.api_host + "/api/admin/accounts/#{id}" }
    let(:params) { {name: "Shop #1"} }
    subject { account.update(id, params) }

    context "when params are valid" do
      before do
        stub_request(:put, url).with(body: {account: params}.to_json).
          to_return(status: 200, body: AdminResponseFixtures.successful_update_account_response)
      end

      it "updates account and return account info" do
        expect(subject.status).to be 200

        expect(subject.success?).to be true

        expect(subject.data.to_h.keys).to contain_exactly *%i(id token name created_at updated_at)

        expect(subject.data.id).to eq(id)
        expect(subject.data.token).to eq("9FHPid4dvvwLc1km2deoApIZshKpXvGOO1Jj4ktmyHWAvGpjicaq7ziZT7Pm3arC")
        expect(subject.data.name).to eq("Shop #1")
        expect(subject.data.created_at.to_s).to_not eq ""
        expect(subject.data.updated_at.to_s).to_not eq ""
      end
    end

    context "when params are invalid" do
      let(:params) { {name: nil} }

      before do
        stub_request(:put, url).with(body: {account: params}.to_json).
          to_return(status: 422, body: AdminResponseFixtures.failed_update_account_response)
      end

      it "returns error response" do
        expect(subject.status).to be 422

        expect(subject.error?).to be true

        expect(subject.error.to_h.keys).to contain_exactly *%i(code message friendly_message help errors)

        expect(subject.error.code).to eq("validation_error")
        expect(subject.error.message).to eq("Parameters are invalid")
        expect(subject.error.friendly_message).to eq("Name can't be blank.")
        expect(subject.error.help).to eq("https://doc.ecomcharge.com/codes/validation_error")
        expect(subject.error.errors).to eq("name" => ["can't be blank"])
      end
    end
  end

end
