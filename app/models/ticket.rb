class Ticket < ApplicationRecord
  validates_presence_of :subject
  validates_numericality_of :age

  has_many :employee_tickets
  has_many :employees, through: :employee_tickets

  def self.ticket_sort
    order(age: :desc)
  end
end
