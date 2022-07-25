class Department < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :floor

  has_many :employees
end
