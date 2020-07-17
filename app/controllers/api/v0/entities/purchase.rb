
class Api::V0::Entities::Purchase < Api::V0::Entities::Base
  expose :tutorial, with: Api::V0::Entities::Tutorial
  expose :deadline
  expose :transaction_records, with: Api::V0::Entities::Record
end