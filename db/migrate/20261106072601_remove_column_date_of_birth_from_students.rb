class RemoveColumnDateOfBirthFromStudents < ActiveRecord::Migration[8.1]
  def change
    remove_column :students, :date_of_birth, :date
  end
end
