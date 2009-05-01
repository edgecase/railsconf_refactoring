class CreateRolls < ActiveRecord::Migration
  def self.up
    create_table :rolls do |t|
      t.integer :score
      t.integer :unused
      t.string :action

      t.timestamps
    end
  end

  def self.down
    drop_table :rolls
  end
end
