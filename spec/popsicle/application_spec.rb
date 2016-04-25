require "spec_helper"

RSpec.describe Popsicle::Application, type: :entity do
  let(:store) { double(:store) }
  let(:app_name) { double(:app_name) }
  let(:headers) { double(:headers) }
  let(:index_key) { double(:index_key) }

  subject do
    described_class.new(store: store,
                        app_name: app_name,
                        headers: headers,
                        index_key: index_key)
  end
  describe "#initialize" do
    it "assigns store, app_name, headers, index_key" do
      expect(subject.store).to eq(store)
      expect(subject.app_name).to eq(app_name)
      expect(subject.headers).to eq(headers)
      expect(subject.index_key).to eq(index_key)
    end
  end
end
