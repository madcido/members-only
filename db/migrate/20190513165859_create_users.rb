class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.index ["email"], name: "index_users_on_email", unique: true
      t.boolean :admin, default: false
      t.string :password_digest
      t.string :remember_digest

      t.timestamps
    end
  end
end
