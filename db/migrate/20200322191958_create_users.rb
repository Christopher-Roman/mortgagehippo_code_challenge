class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :api_key
      t.boolean :admin
      t.string :email

      t.timestamps
    end
  end
end
