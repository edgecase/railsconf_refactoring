class CreateTurns < ActiveRecord::Migration
  def self.up
    create_table :turns do |t|
      t.integer :game_id
      t.integer :player_id
      t.integer :score
      t.timestamps
    end
  end

  def self.down
    drop_table :turns
  end
end
