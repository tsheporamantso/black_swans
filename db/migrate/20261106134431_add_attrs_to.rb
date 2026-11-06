class AddAttrsTo < ActiveRecord::Migration[8.1]
  def change
    add_column :students, :permanent_address, :string
    add_column :students, :local_address, :string
  end
end
