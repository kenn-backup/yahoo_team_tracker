class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.integer :score, default: 0
      t.integer :user_id, null: false
      t.timestamps null: false
    end
  end
end
