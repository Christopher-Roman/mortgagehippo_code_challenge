class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :name
      t.integer :value
      t.string :api_key
      t.string :transaction_type

      t.timestamps
    end
  end
end