class CreateComputerPlayers < ActiveRecord::Migration
  def self.up
    create_table :computer_players do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :computer_players
  end
end
