class ChangeColumnDateOfBirthToDate < ActiveRecord::Migration[8.1]
  def change
    change_column :students, :date_of_birth, :date
  end
end
