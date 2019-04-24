class AddIndexToCustomersCompany < ActiveRecord::Migration[5.2]
  def change
    add_index :customers, :company, unique:true
  end
end
