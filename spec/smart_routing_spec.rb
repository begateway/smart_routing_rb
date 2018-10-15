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
        old = SmartRouting.open_tomeout
        SmartRouting.open_tomeout = 5

        expect(SmartRouting.open_tomeout).to eq(5)
      ensure
        SmartRouting.open_tomeout= old
      end
    end

    it "allows read_tomeout to be configured" do
      begin
        old = SmartRouting.read_tomeout
        SmartRouting.read_tomeout = 10

        expect(SmartRouting.read_tomeout).to eq(10)
      ensure
        SmartRouting.read_tomeout= old
      end
    end

    it "has default open_tomeout and read_tomeout" do
      expect(SmartRouting.open_tomeout).to eq(20)
      expect(SmartRouting.read_tomeout).to eq(40)
    end

  end
end
