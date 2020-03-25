class CreateAdmin < ActiveRecord::Migration[6.0]
  def change
    create_table :admins do |t|
      t.string :email
    end
  end
end
