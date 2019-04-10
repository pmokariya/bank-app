class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name
      t.decimal :balance , :precision => 8, :scale => 2
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
