class AddAccountNumberAccountHolderNameToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :account_number, :string
    add_column :transactions, :account_holder_name, :string
  end
end
