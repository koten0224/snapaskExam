class Api::ApiRoot < Grape::API
  format :json
  mount Api::V0::Base
end