require 'rails_helper'

RSpec.describe "Students", type: :request do
  let(:admin_user) { create(:admin_user) }

  before do
    sign_in admin_user
  end

  describe "GET /students" do
    it "returns a successful response" do
      get students_path

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end

    it "redirects unauthenticated users to sign in" do
      sign_out admin_user

      get students_path

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(new_admin_user_session_path)
    end
  end
  
  describe "POST /students" do
    it "creates a student and redirects to the students index" do
      
      expect {
        post students_path, params: {
          student: {
            first_name: "Tshepo",
            last_name: "Ramantso",
            email: "tgramanatso@example.com",
            permanent_address: "Roodepoort",
            local_address: "Rockville",
            permanent_contact_number: "0841443709",
            alternative_contact_number: "0651443709"
            }
          }
        }.to change(Student, :count).by(1)
        expect(response).to redirect_to(students_path)
        expect(flash[:notice]).to eq("Student created successfully.")
    end

    it "does not create a student with invalid attributes" do
      
      expect {
        post students_path, params: {
          student: {
            first_name: "Tshepo2",
            last_name: "Ramantso",
            email: "invalid email",
          }
        }
      }.not_to change(Student, :count)
      expect(response).to have_http_status(:unprocessable_content)
      expect(response).to render_template(:new)
    end
  end

  
  describe "PATCH /students" do
    it "update student, redirect to show and send flash message" do
      student = create(:student)

      patch student_path(student), params: {
        student: {
          first_name: "Gladwin"
        }
      }
      student.reload
      expect(student.first_name).to eq("Gladwin")
      expect(response).to redirect_to(student_path(student))
      expect(flash[:notice]).to eq("Student updated successfully.")
    end

    it "does not update student and returns 422 HTTP status" do
      student = create(:student)

      patch student_path(student), params: {
        student: {
          email: "invalid email"
        }
      }
      student.reload
      expect(student.email).to eq("tshepo2@example.com")
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:unprocessable_content)
    end
  end

  describe "DELETE /students" do
    it "should delete student record" do
      student = create(:student)
      
      expect {
        delete student_path(student)
      }.to change(Student, :count).by(-1)

      expect(response).to redirect_to(students_path)
      expect(flash[:notice]).to eq("Student deleted successfully.")
    end
  end
end
