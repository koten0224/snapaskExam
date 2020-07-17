
class Api::V0::Entities::Tutorial < Api::V0::Entities::Base
  expose :id
  expose :title
  expose :price
  expose :price_type
  expose :catagory
  expose :available
  expose :url
  expose :desc
  expose :expiration
end
