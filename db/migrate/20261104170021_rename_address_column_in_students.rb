class RenameAddressColumnInStudents < ActiveRecord::Migration[8.1]
  def change
    rename_column :students, :address, :permanent_address
  end
end
