class Employee < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :level

  belongs_to :department

  has_many :employee_tickets
  has_many :tickets, through: :employee_tickets

end
