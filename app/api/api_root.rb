class ApiRoot < Grape::API
  format :json
  mount V0::Base
end