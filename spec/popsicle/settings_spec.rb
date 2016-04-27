require "spec_helper"

RSpec.describe Popsicle::Settings, type: :entity do
  subject { described_class.new }
  let(:filename) { File.expand_path(".", "settings.sample.yml.erb") }
  let(:expected_settings) do
    YAML.load(ERB.new(File.read(filename)).result)
  end

  describe "#initialize" do
    it "takes in a filename, and raises an error if the file does not exist" do
      expect { described_class.new }.not_to raise_error
      expect { described_class.new(filename: "/undefined/path") }.to raise_error(ArgumentError)
    end
  end

  describe "#load" do
    it "evaluates the settings" do
      expect(subject.load).to eq(expected_settings)
    end
  end

  describe "#[]" do
    before do
      subject.load
    end

    context "with a found key" do
      it "returns the value" do
        expect(subject["popsicle"]["app_name"]).to eq(expected_settings["popsicle"]["app_name"])
      end
    end

    context "without one" do
      it "raises KeyError" do
        expect { subject[:yolo] }.to raise_error(KeyError)
      end
    end
  end
end
