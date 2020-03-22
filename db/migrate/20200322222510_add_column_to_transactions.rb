class AddColumnToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :column, :string
  end
end
