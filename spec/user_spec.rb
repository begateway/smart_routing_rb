RSpec.describe SmartRouting::User do
  let(:headers) { {'X-Request-Id' => 'r12'} }
  let(:auth_login) { 'login' }
  let(:auth_password) { 'password' }
  let(:options) { {auth_login: auth_login, auth_password: auth_password, headers: headers} }

  context "initialization" do
    subject { described_class.new(options) }

    it "assigns auth_login, auth_password and headers" do
      expect(subject.headers).to eq(headers)
      expect(subject.auth_login).to eq(auth_login)
      expect(subject.auth_password).to eq(auth_password)
    end
  end

  context ".rule" do
    subject { described_class.new(options).rule }

    it "returns instance of SmartRouting::User::Rule" do
      expect(subject).to be_an_instance_of(SmartRouting::User::Rule)
    end
  end

  context ".set" do
    subject { described_class.new(options).set }

    it "returns instance of SmartRouting::User::Set" do
      expect(subject).to be_an_instance_of(SmartRouting::User::Set)
    end
  end

  context ".object_type" do
    subject { described_class.new(options).object_type }

    it "returns instance of SmartRouting::User::ObjectType" do
      expect(subject).to be_an_instance_of(SmartRouting::User::ObjectType)
    end
  end

  context ".object" do
    subject { described_class.new(options).object }

    it "returns instance of SmartRouting::User::Object" do
      expect(subject).to be_an_instance_of(SmartRouting::User::Object)
    end
  end

  context ".white_lists" do
    subject { described_class.new(options).white_lists }

    it "returns instance of SmartRouting::User::Object" do
      expect(subject).to be_an_instance_of(SmartRouting::User::Wbl::WhiteLists)
    end
  end

  context ".black_lists" do
    subject { described_class.new(options).black_lists }

    it "returns instance of SmartRouting::User::Object" do
      expect(subject).to be_an_instance_of(SmartRouting::User::Wbl::BlackLists)
    end
  end

  context ".wb_lists" do
    subject { described_class.new(options).wb_lists }

    it "returns instance of SmartRouting::User::Object" do
      expect(subject).to be_an_instance_of(SmartRouting::User::Wbl::United)
    end
  end
end
