require "rails_helper"

RSpec.describe "Student management workflow", type: :feature do

  before do
    create(:admin_user)

    visit new_admin_user_session_path

    within("#new_admin_user") do
      fill_in "Email", with: "john.doe@example.com"
      fill_in "Password", with: "password123"

      click_button "Sign in"
    end
  end

  it "should display student list" do
    visit students_path

    expect(page).to have_current_path(students_path )
    expect(page).to have_content("Student")
    expect(page).to have_link("Create New Student", href: "/students/new")
  end

  it "should render Ransack search field and button" do
    visit students_path

    expect(page).to have_field("q[first_name_or_last_name_or_email_cont]")
    expect(page).to have_button('Search')

    click_button "Search"

  end

  it "should render CTA buttons" do
    student = create(:student)

    visit students_path(page:2)

    within("#student_#{student.id}") do
      expect(page).to have_link("View Details", href: student_path(student))
      expect(page).to have_link("Edit Student", href: edit_student_path(student))
      expect(page).to have_button("Delete Student")
    end
  end

  it "should navigate to the student edit page" do
    student = create(:student)

    visit students_path(page:2)

    within("#student_#{student.id}") do
      click_link "Edit Student"
    end

    expect(page).to have_current_path(edit_student_path(student))
    expect(page).to have_content("Update Student Details")
    expect(page).to have_link("Back to Student", href: students_path)
    expect(page).to have_button("Update Student")
  end

  it "should navigate to the student view/show page" do
    student = create(:student)

    visit students_path(page: 2)

    within("#student_#{student.id}") do
      click_link "View Details"
    end

    expect(page).to have_current_path(student_path(student))
  end

  it "should delete a student" do
    student = create(:student)

    visit students_path(page: 2)

    within("#student_#{student.id}") do
      accept_confirm do
        click_button "Delete Student"
      end
    end
    expect(page).to have_content("Student deleted successfully")
    expect(Student.exists?(student.id)).to be (false)
  end
end
