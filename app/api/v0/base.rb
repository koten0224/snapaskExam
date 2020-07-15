module V0
  class Base < Grape::API
    version 'v0', using: :path
    mount Ping
    mount Tutorial
    mount Registration
  end
end