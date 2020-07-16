module V0
  class Base < Grape::API
    version 'v0', using: :path
    helpers V0::Helpers
    mount Ping
    mount Tutorial
    mount Registration
    mount Login
    mount Purchase
  end
end