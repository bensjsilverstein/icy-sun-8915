require 'rails_helper'

RSpec.describe 'deparment index page' do
  it "has each departments name and floor" do
    dep1 = Department.create!(name: "Accounting", floor: "2nd floor")
    dep2 = Department.create!(name: "Shipping", floor: "1st floor")
    dep3 = Department.create!(name: "Managment", floor: "3rd floor")

    visit '/departments'

    expect(page).to have_content("Department: Accounting")
    expect(page).to have_content("Department: Shipping")
    expect(page).to have_content("Department: Managment")
    expect(page).to have_content("Floor: 1st floor")
    expect(page).to have_content("Floor: 2nd floor")
    expect(page).to have_content("Floor: 3rd floor")

    expect(page).to_not have_content("Deparment: Receiving")
  end

  it "shows the names of each department employee under its name" do
    dep1 = Department.create!(name: "Accounting", floor: "2nd floor")
    dep2 = Department.create!(name: "Shipping", floor: "1st floor")
    dep3 = Department.create!(name: "Managment", floor: "3rd floor")

    ron = dep1.employees.create!(name: "Ronald", level: 1)
    harry = dep1.employees.create!(name: "Harry", level: 2)
    hermione = dep2.employees.create!(name: "Hermione", level: 3)
    hagrid = dep2.employees.create!(name: "Hagrid", level: 4)

    visit '/departments'

    within "#department-#{dep1.id}" do
      expect(page).to have_content("Ronald")
      expect(page).to have_content("Harry")
      expect(page).to_not have_content("Hermione")
      expect(page).to_not have_content("Hagrid")
    end
    within "#department-#{dep2.id}" do
      expect(page).to have_content("Hermione")
      expect(page).to have_content("Hagrid")
      expect(page).to_not have_content("Ronald")
      expect(page).to_not have_content("Harry")
    end
    within "#department-#{dep3.id}" do
      expect(page).to_not have_content("Hermione")
      expect(page).to_not have_content("Hagrid")
      expect(page).to_not have_content("Ronald")
      expect(page).to_not have_content("Harry")
    end
    # save_and_open_page
  end
end
