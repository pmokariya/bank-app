class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.decimal :price, :precision => 8, :scale => 2
      t.string :msg
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
