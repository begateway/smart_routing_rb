RSpec.shared_examples "successful response" do
  it "returns successful response" do
    expect(subject.status).to be http_status

    expect(subject.success?).to be true
    expect(subject.error?).to be false

    expect(subject.data.to_h.keys).to contain_exactly *data_attrs
    # check access to attribute as method: subject.data.name
    respond_to?(:request_params) && request_params.each do |key, value|
      expect(subject.data.public_send(key)).to eq(value)
    end
  end
end

RSpec.shared_examples "successful items response" do
  it "returns successful items response" do
    expect(subject.status).to be http_status

    expect(subject.success?).to be true
    expect(subject.error?).to be false

    subject.data.each do |item|
      expect(item.to_h.keys).to contain_exactly *data_attrs
      # check access to attribute as method: subject.error.code
      data_attrs.each do |attr|
        expect(item.respond_to? attr).to be true
      end
    end
  end
end

RSpec.shared_examples "error response" do
  it "returns error response" do
    expect(subject.success?).to be false
    expect(subject.error?).to be true

    expect(subject.error.to_h.keys).to contain_exactly *error_keys
    # check access to attribute as method: subject.error.code
    error_keys.each do |key|
      expect(subject.error.respond_to? key).to be true
    end
  end
end
