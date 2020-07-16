module V0
  module Entities
    class Purchase < Entities::Base
      expose :tutorial, with: V0::Entities::Tutorial
      expose :deadline
      expose :transaction_records, with: V0::Entities::Record
    end
  end
end
