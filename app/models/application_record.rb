# all models inherit from ApplicationRecord in Rails 5
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
