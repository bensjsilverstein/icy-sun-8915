require 'rails_helper'

RSpec.describe 'employee show page' do
  it "has the employee's name and department" do
    dep1 = Department.create!(name: "Accounting", floor: "2nd floor")
    dep2 = Department.create!(name: "Shipping", floor: "1st floor")
    dep3 = Department.create!(name: "Managment", floor: "3rd floor")

    ron = dep1.employees.create!(name: "Ronald", level: 1)
    harry = dep1.employees.create!(name: "Harry", level: 2)
    hermione = dep2.employees.create!(name: "Hermione", level: 3)
    hagrid = dep2.employees.create!(name: "Hagrid", level: 4)

    ticket_1 = Ticket.create!(subject: "laptop not charging", age: 1)
    ticket_2 = Ticket.create!(subject: "weak wifi signal", age: 2)
    ticket_3 = Ticket.create!(subject: "dark computer screen", age: 3)

    visit "/employees/#{ron.id}"

    expect(page).to have_content("Employee: Ronald")
    expect(page).to have_content("Employee Department: Accounting")
    expect(page).to_not have_content("Employee Name: Harry")
    expect(page).to_not have_content("Employee Department: Shipping")
    # save_and_open_page
  end

  it "has a list of the employee's tickets from oldest to youngest" do
    dep1 = Department.create!(name: "Accounting", floor: "2nd floor")
    dep2 = Department.create!(name: "Shipping", floor: "1st floor")
    dep3 = Department.create!(name: "Managment", floor: "3rd floor")

    ron = dep1.employees.create!(name: "Ronald", level: 1)
    harry = dep1.employees.create!(name: "Harry", level: 2)
    hermione = dep2.employees.create!(name: "Hermione", level: 3)
    hagrid = dep2.employees.create!(name: "Hagrid", level: 4)

    ticket_1 = Ticket.create!(subject: "laptop not charging", age: 1)
    ticket_2 = Ticket.create!(subject: "weak wifi signal", age: 2)
    ticket_3 = Ticket.create!(subject: "dark computer screen", age: 3)

    EmployeeTicket.create!(employee_id: ron.id , ticket_id: ticket_1.id )
    EmployeeTicket.create!(employee_id: harry.id, ticket_id: ticket_1.id )
    EmployeeTicket.create!(employee_id: hermione.id, ticket_id: ticket_2.id )
    EmployeeTicket.create!(employee_id: ron.id , ticket_id: ticket_3.id)
    EmployeeTicket.create!(employee_id: ron.id , ticket_id: ticket_2.id)

    visit "/employees/#{ron.id}"

    expect(Ticket.ticket_sort.first).to eq(ticket_3)
    expect(Ticket.ticket_sort.last).to eq(ticket_1)
    expect(page).to have_content("laptop not charging")
    save_and_open_page
  end

end
