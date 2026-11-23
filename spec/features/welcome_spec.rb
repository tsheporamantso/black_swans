require 'rails_helper'

RSpec.feature "Welcomes", type: :feature do
  it "displays welcome page" do
    visit root_path

    expect(page).to have_content("Student Management")
    expect(page).to have_link("Student", href: students_path)
    expect(page).to have_link("Sign in", href: new_admin_user_session_path)
  end
  

end
 

