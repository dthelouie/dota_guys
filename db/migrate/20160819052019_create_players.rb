class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.references :match
      t.string :uid
      t.text :hero
      t.integer :level
      t.integer :kills
      t.integer :deaths
      t.integer :assists
      t.integer :last_hits
      t.integer :denies
      t.integer :gold
      t.integer :gpm
      t.integer :xpm
      t.string :status
      t.integer :gold_spent
      t.integer :hero_damage
      t.integer :tower_damage
      t.integer :hero_healing
      t.text :items
      t.integer :slot
      t.boolean :radiant

    end
  end
end
