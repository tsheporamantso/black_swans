class AddColumnsColumnsToStudents < ActiveRecord::Migration[8.1]
  def change
    add_column :students, :permanent_contact_number, :string
    add_column :students, :alternative_contact_number, :string
  end
end
