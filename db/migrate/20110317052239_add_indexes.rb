class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :bites_photos, :bite_id
    add_index :bites_photos, :photo_id
  end

  def self.down
    remove_index :bites_photos, :photo_id
    remove_index :bites_photos, :bite_id
  end
end
