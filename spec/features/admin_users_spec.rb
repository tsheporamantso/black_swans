require 'rails_helper'

RSpec.describe "Admin user sign in", type: :feature do

  before do
    create(:admin_user)
  end

  it "signs the admin user in successfully" do
    visit new_admin_user_session_path
   
    within("#new_admin_user") do
      fill_in "Email", with: "john.doe@example.com"
      fill_in "Password", with: "password123"
     

      click_button "Sign in"
    end

    expect(page).to have_content("Signed in successfully")
    expect(page).to have_current_path(students_path)
  end

  it "does not authenticate user with incorrect credentials" do
    visit new_admin_user_session_path

    within("#new_admin_user") do
      fill_in "Email", with: "tshepo.ramantso@example.com"
      fill_in "Password", with: "incorrectpassword"

      click_button "Sign in"
    end

    expect(page).to have_content("Invalid email or password")
  end

  it "does not authenticate user with blank password" do
    visit new_admin_user_session_path

    within("#new_admin_user") do
      fill_in "Email", with: "john.doe@example.com"
      fill_in "Password", with: ""

      click_button "Sign in"
    end

    expect(page).to have_content("Invalid email or password")
    expect(page).to have_current_path(new_admin_user_session_path)
  end
  it "sign out user successfully" do
    visit new_admin_user_session_path

    within("#new_admin_user") do
      fill_in "Email", with: "john.doe@example.com"
      fill_in "Password", with: "password123"

      click_button "Sign in"
    end

    expect(page).to have_content("Signed in successfully")
    expect(page).to have_current_path(students_path)

    click_button "Sign out"

    expect(page).to have_current_path(root_path)
  end
  it "prevents unathenticated users from accessing students" do
    visit students_path

    expect(page).to have_current_path(new_admin_user_session_path)
    expect(page).to have_content("You need to sign in or sign up before continuing")
  end
end
