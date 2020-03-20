class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :coin
      t.string :created_by

      t.timestamps
    end
  end
end
