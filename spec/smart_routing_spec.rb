RSpec.describe SmartRouting do
  it "has a version number" do
    expect(SmartRouting::VERSION).not_to be nil
  end

  context "configuration" do
    let(:logger) { double(:logger) }

    it "allows api_host to be configured" do
      begin
        old = SmartRouting.api_host
        SmartRouting.api_host = "https://api.host.com"

        expect(SmartRouting.api_host).to eq("https://api.host.com")
      ensure
        SmartRouting.api_host = old
      end
    end

    it "allows logger to be configured" do
      begin
        old = SmartRouting.logger
        SmartRouting.logger = logger

        expect(SmartRouting.logger).to eq(logger)
      ensure
        SmartRouting.logger = old
      end
    end

    it "allows open_tomeout to be configured" do
      begin
        old = SmartRouting.open_timeout
        SmartRouting.open_timeout = 5

        expect(SmartRouting.open_timeout).to eq(5)
      ensure
        SmartRouting.open_timeout = old
      end
    end

    it "allows read_timeout to be configured" do
      begin
        old = SmartRouting.read_timeout
        SmartRouting.read_timeout = 10

        expect(SmartRouting.read_timeout).to eq(10)
      ensure
        SmartRouting.read_timeout = old
      end
    end

    it "has default open_timeout and read_timeout" do
      expect(SmartRouting.open_timeout).to eq(20)
      expect(SmartRouting.read_timeout).to eq(40)
    end

    it "allows proxy to be configured" do
      begin
        old = SmartRouting.proxy
        SmartRouting.proxy = "http://127.0.0.1:3214/"

        expect(SmartRouting.proxy).to eq("http://127.0.0.1:3214/")
      ensure
        SmartRouting.read_timeout = old
      end
    end

  end
end
