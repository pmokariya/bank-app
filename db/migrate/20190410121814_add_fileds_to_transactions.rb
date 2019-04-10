class AddFiledsToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :from_account, :integer
    add_column :transactions, :to_account, :integer
  end
end
