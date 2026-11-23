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
    students = create_list(:student, 3)

    visit students_path

    expect(page).to have_current_path(students_path )
    expect(page).to have_content("Manage and view registered students.")
    expect(page).to have_link("Create New Student", href: "/students/new")

    within("#students") do
      expect(page).to have_css("div[id^= 'student_']", count: 2)
      expect(page).to have_content(students[0].full_name)
      expect(page).to have_content(students[1].full_name)

      expect(page).not_to have_content(students[2].email)
    end
  end

  it "should render Ransack search field and button" do

    visit students_path

    expect(page).to have_field("q[first_name_or_last_name_or_email_cont]")
    expect(page).to have_button('Search')

  end

  it "should filter students when a search term is submitted" do
    matching_student = create(:student)
    create(:student, first_name: "John", last_name: "Doe", email: "john.doe@example.com")

    visit students_path

    fill_in "q[first_name_or_last_name_or_email_cont]", with: "tshepo"
    click_button "Search"

    puts page.current_url

    expect(page).to have_content(matching_student.full_name)
    expect(page).not_to have_content("John Doe")
    expect(page).to have_css("div[id^='student_']", count: 1)
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

    expect(page).to have_content("Update Student Details")
  end

  it "should render edit student details form" do
    student = create(:student)
    
    fields = %w[
      student_first_name
      student_last_name
      student_email
      student_permanent_address
      student_local_address
      student_permanent_contact_number
      student_alternative_contact_number
    ]

    visit students_path
    
    click_link "Edit Student"
   
    expect(page).to have_current_path(edit_student_path(student))
    
    fields.each do |field|
      expect(page).to have_field(field)
    end 
  end

  it "should navigate to the student view/show page" do
    student = create(:student)

    visit students_path(page: 2)

    within("#student_#{student.id}") do
      click_link "View Details"
    end

    expect(page).to have_current_path(student_path(student))
  end

#  it "should delete a student" do
 #   student = create(:student)

  #  visit students_path(page: 2)

   # within("#student_#{student.id}") do
    #  accept_confirm do
       # click_button "Delete Student"
     # end
   # end
    #expect(page).to have_content("Student deleted successfully")
    #expect(Student.exists?(student.id)).to be (false)
 # end
end
