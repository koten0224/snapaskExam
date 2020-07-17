class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  CURRENCIES = ["TWD", "USD"]
end
