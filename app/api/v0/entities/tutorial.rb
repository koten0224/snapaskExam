module V0
  module Entities
    class Tutorial < Entities::Base
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
  end
end