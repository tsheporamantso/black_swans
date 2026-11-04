class AddColumnToStudents < ActiveRecord::Migration[8.1]
  def change
    add_column :students, :dob, :string
    add_column :students, :address, :string
    add_column :students, :age, :string
  end
end
