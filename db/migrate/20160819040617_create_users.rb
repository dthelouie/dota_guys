class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid, unique: true, null: false
      t.string :nickname, null: false
      t.string :avatar_url, null: false
      t.string :profile_url, null: false
    end
  end
end
