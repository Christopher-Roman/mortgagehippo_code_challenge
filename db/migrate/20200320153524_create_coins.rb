class CreateCoins < ActiveRecord::Migration[6.0]
  def change
    create_table :coins do |t|
      t.string :name
      t.integer :value
      t.string :api_key

      t.timestamps
    end
  end
end