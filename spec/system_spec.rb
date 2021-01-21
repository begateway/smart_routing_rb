RSpec.describe "system" do
  context "logging request and response" do
    require 'stringio'
    require 'logger'

    let(:strio)  { StringIO.new }
    let(:logger) { Logger.new strio }
    let(:account) { SmartRouting::Admin::Account.new(admin_client) }
    let(:url) { SmartRouting.api_host + "/api/admin/accounts" }
    let(:data) { {name: 'name1'} }
    let(:body_response) { AdminResponseFixtures.successful_creation_account_response }
    let(:request) { account.create(data) }

    before do
      SmartRouting.logger = logger

      stub_request(:post, url).
        to_return(status: 201, body: body_response)

      request
    end

    subject { strio.string }

    it "writes response and request to log" do
      expect(subject).to include("Request: start POST to #{url}")
      expect(subject).to_not include("9FHPid4dvvwLc1km2deoApIZshKpXvGOO1Jj4ktmyHWAvGpjicaq7ziZT7Pm3arC")
      expect(subject).to include("9FHPi*****m3arC")
      expect(subject).to include("Response: status 201")
    end

    context "when client has request id in headers" do
      let(:request_id) { 'request-id-1' }
      let(:account) { SmartRouting::Admin::Account.new(admin_client_with_request_id(request_id)) }

      it "writes request_id to request and to response" do
        # request
        expect(subject).to include("Request: start POST to #{url}  (#{request_id})")
        expect(subject).to include("{\"account\":#{data.to_json}}  (#{request_id})")
        # response
        expect(subject).to include("Response: status 201   (#{request_id})")
        expect(subject).to match(/token.+ \(#{request_id}\)/)
      end

      it "adds X-Request-Id passed header to response headers" do
        request_headers = request.response.env.request_headers
        expect(request_headers["X-Request-Id"]).to eq(request_id)
      end
    end
  end
end
