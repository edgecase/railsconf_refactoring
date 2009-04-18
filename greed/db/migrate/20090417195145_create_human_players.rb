class CreateHumanPlayers < ActiveRecord::Migration
  def self.up
    create_table :human_players do |t|
      t.string :name
      t.integer :score
      t.integer :game_id

      t.timestamps
    end
  end

  def self.down
    drop_table :players
  end
end
