class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  CURRENCIES = {
    TWD: 0, 
    USD: 1
  }
end
