class ColumnToTransaction < ActiveRecord::Migration[6.0]
  def change
    remove_column :transactions, :column
  end
end
