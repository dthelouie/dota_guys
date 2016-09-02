class AddMatchUidIndex < ActiveRecord::Migration
  def change
    add_index :matches, :uid
  end
end
