class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :project_name
      t.references :customer, foreign_key: true

      t.timestamps
    end
    add_index :projects, [:project_name, :customer_id]
  end
end
