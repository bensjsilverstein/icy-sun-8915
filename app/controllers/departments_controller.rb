class DepartmentsController < ApplicationController
  def index
    @departments = Department.all.order(floor: :asc)
  end
end
