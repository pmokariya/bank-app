class AddAccountToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :account, foreign_key: true
  end
end
