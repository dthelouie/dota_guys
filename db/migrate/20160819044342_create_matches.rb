class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :uid
      t.string :winner
      t.string :first_blood
      t.datetime :started_at
      t.string :mode
      t.string :match_type
      t.string :duration
      t.integer :cluster
      t.references :user
    end
  end
end
