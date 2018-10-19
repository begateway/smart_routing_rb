RSpec.describe SmartRouting::LogSanitizer do
  let(:body) { %!{"data":{"token":"9FHPid4dvvwLc1k","name":"Shop #1","id":"03-7e1c360f7467"}}! }

  context ".sanitize" do

    subject { described_class.sanitize(body) }

    it "filters token" do
      expect(subject).to eq %!{"data":{"token":"9FHPi*****wLc1k","name":"Shop #1","id":"03-7e1c360f7467"}}!
    end
  end
end
