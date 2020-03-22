class AddTransactionKeyValuePair < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :coin_id, :string
  end
end
