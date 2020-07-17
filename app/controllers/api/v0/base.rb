class Api::V0::Base < Grape::API
  version 'v0', using: :path
  helpers Api::V0::Helpers
  mount Ping
  mount Tutorial
  mount Registration
  mount Login
  mount Purchase
end
