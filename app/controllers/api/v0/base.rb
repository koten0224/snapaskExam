class Api::V0::Base < Grape::API
  version 'v0', using: :path
  helpers Api::V0::Helpers
  mount Ping
  mount Tutorial
  mount Registration
  mount Login
  mount Purchase

  add_swagger_documentation(
    mount_path: 'doc',
    hide_format: true,
    hide_documentation_path: true
  )

end
