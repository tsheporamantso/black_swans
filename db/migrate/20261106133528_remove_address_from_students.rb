class RemoveAddressFromStudents < ActiveRecord::Migration[8.1]
  def change
    remove_column :students, :permanent_address, :string
  end
end
