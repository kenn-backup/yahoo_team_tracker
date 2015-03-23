class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :position, null: false
      t.string :pro_team, null: false
      t.integer :age, null: false
      t.timestamps null: false
    end
  end
end
