class AddColumnToProjects < ActiveRecord::Migration[8.1]
  def change
    add_column :projects, :submission_date, :date
  end
end
