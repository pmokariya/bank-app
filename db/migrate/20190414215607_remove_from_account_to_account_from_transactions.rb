class RemoveFromAccountToAccountFromTransactions < ActiveRecord::Migration[5.2]
  def change
  	remove_column :transactions, :from_account, :integer
    remove_column :transactions, :to_account, :integer
  end
end
