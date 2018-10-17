RSpec.describe SmartRouting::Admin do
  let(:auth_login) { 'login' }
  let(:auth_password) { 'password' }
  let(:options) { {auth_login: auth_login, auth_password: auth_password} }

  context "initialization" do
    subject { described_class.new(options) }

    it "assigns auth_login and auth_password" do
      expect(subject.auth_login).to eq(auth_login)
      expect(subject.auth_password).to eq(auth_password)
    end
  end

  context ".account" do
    subject { described_class.new(options).account }

    it "returns instance of SmartRouting::Admin::Account" do
      expect(subject).to be_an_instance_of(SmartRouting::Admin::Account)
    end
  end

end
