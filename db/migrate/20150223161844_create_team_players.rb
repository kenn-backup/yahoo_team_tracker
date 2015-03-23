class CreateTeamPlayers < ActiveRecord::Migration
  def change
    create_table :team_players do |t|
      t.integer :team_id, null: false
      t.integer :player_id, null: false
      t.timestamps null: false
    end
  end
end