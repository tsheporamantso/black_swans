class CreateFaculties < ActiveRecord::Migration[8.1]
  def change
    create_table :faculties do |t|
      t.string :faculty_name
      t.text :faculty_description
      t.references :faculty_dean, null: false, foreign_key: true

      t.timestamps
    end
  end
end
