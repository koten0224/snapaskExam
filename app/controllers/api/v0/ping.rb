class Api::V0::Ping < Grape::API
  desc "Ping pong"
  get "/ping" do
    "pong"
  end
end
