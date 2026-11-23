require 'rails_helper'

RSpec.describe "Students", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "visiting the students index" do
    it "displays the students heading" do
      visit students_path

      expect(page).to have_content("Students")
    end
  end

end
