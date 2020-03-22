class RenameTransactionKeyValuePairs < ActiveRecord::Migration[6.0]
  def change
  	rename_column :transactions, :coin, :name
  	rename_column :transactions, :created_by, :value
  end
end
