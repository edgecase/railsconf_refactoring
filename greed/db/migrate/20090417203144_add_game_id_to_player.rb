class AddGameIdToPlayer < ActiveRecord::Migration
  def self.up
    add_column :players, :game_id, :integer
  end

  def self.down
    remove_column :players, :game_id
  end
end
