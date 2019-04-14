class AddFieldsToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :account_number, :integer
    add_column :accounts, :account_type, :string
  	rename_column :accounts, :name, :account_holder_name
  	rename_column :accounts, :balance, :amount
  end
end
