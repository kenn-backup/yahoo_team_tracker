class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false, uniqueness: true
      t.string :email, null: false, uniqueness: true
      t.timestamps null: false
    end
  end
end
