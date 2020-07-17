
class Api::V0::Entities::Tutorial < Api::V0::Entities::Base
  expose :id
  expose :title
  expose :price
  expose :currency
  expose :display_category
  expose :available
  expose :url
  expose :desc
  expose :expiration
end
