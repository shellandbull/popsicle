require "spec_helper"

RSpec.describe "popsicle/acceptance/request", type: :acceptance do
  let(:mock_redis) { MockRedis.new }
  let(:app_name) { "hyperdrive" }
  let(:index_key) { "hidden-features" }
  let(:headers) do
    {
      "Accept" => "text/html"
    }
  end
  let(:app_settings) do
    {
      store: mock_redis,
      app_name: app_name,
      headers: headers,
      index_key: index_key
    }
  end

  def app
    @app ||= Popsicle::Application.new(store: app_settings[:store],
                                       app_name: app_settings[:app_name],
                                       headers: app_settings[:headers],
                                       index_key: app_settings[:index_key])
  end

  describe "Making a request to the server" do
    let(:revision_value) { "12345" }
    let(:revision_key) { "#{app_name}:index:#{revision_value}" }
    let(:expected_body) { "foobar" }

    before do
      mock_redis.set(revision_key, expected_body)
      mock_redis.set("#{app_name}:index:current", revision_key)
    end

    describe "configurable settings" do
      before do
        get "/"
      end

      describe "headers" do
        it "includes the specified headers on the response" do
          expect(last_response.headers["Accept"]).to eq(app_settings[:headers]["Accept"])
        end
      end
    end

    context "Without an index key" do
      before do
        get "/"
      end

      it "200 - Ok" do
        expect(last_response.status).to eq(200)
      end
    end

    context "when something naughty happens" do
      before do
        allow(app).to receive(:found_revision) do
          fail StandardError, "Something bad happened"
        end

        allow(app.logger).to receive(:error)
        get "/"
      end

      it "500 - Server error" do
        expect(last_response.status).to eq(500)
      end

      it "returns the type of error, yet not the stacktrace" do
        expect(last_response.body).to eq("StandardError")
      end
    end

    context "With an index key" do
      context "when the index key has a valid value" do
        before do
          get "/", { index_key => revision_value }
        end

        it "200 - Ok" do
          expect(last_response.status).to eq(200)
        end

        it "fetches the default revision" do
          expect(last_response.body).to eq(expected_body)
        end
      end
    end
  end
end
