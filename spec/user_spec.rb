RSpec.describe SmartRouting::User do
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

  context ".rule" do
    subject { described_class.new(options).rule }

    it "returns instance of SmartRouting::User::Rule" do
      expect(subject).to be_an_instance_of(SmartRouting::User::Rule)
    end
  end

end
