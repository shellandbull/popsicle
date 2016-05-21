require "spec_helper"

RSpec.describe Popsicle::Application, type: :entity do
  let(:store) { double(:store) }
  let(:app_name) { double(:app_name) }
  let(:headers) { double(:headers) }
  let(:index_key) { double(:index_key) }

  subject do
    described_class.new.tap do |instance|
      instance.store     = store
      instance.app_name  = app_name
      instance.headers   = headers
      instance.index_key = index_key
    end
  end

  describe "attributes" do
    it "store" do
      expect(subject.store).to eq(store)
    end

    it "app_name" do
      expect(subject.app_name).to eq(app_name)
    end

    it "headers" do
      expect(subject.headers).to eq(headers)
    end

    it "index_key" do
      expect(subject.index_key).to eq(index_key)
    end
  end
end
