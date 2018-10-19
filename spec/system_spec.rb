RSpec.describe "system" do
  context "logging request and response" do
    require 'stringio'
    require 'logger'

    let(:strio)  { StringIO.new }
    let(:logger) { Logger.new strio }
    let(:account) { SmartRouting::Admin::Account.new(admin_client) }
    let(:url) { SmartRouting.api_host + "/api/admin/accounts" }

    before do
      SmartRouting.logger = logger

      stub_request(:post, url).
        to_return(body: AdminResponseFixtures.successful_creation_account_response)

      account.create({})
    end

    subject { strio.string }

    it "writes response and request to log" do
      expect(subject).to include("Request: start POST to #{url}")
      expect(subject).to_not include("9FHPid4dvvwLc1km2deoApIZshKpXvGOO1Jj4ktmyHWAvGpjicaq7ziZT7Pm3arC")
      expect(subject).to include("9FHPi*****m3arC")
      expect(subject).to include("Response: status 200")
    end
  end

end
