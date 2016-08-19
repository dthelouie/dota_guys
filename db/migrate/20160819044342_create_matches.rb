class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :uid, unique: true, null: false
      t.string :winner, null: false
      t.datetime :started_at, null: false
      t.string :mode, null: false
      t.string :match_type, null: false
      t.string :duration, null: false
      t.references :user
    end
  end
end
