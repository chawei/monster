class BitesPhotos < ActiveRecord::Migration
  def self.up
    create_table :bites_photos, :id => false do |t|
      t.integer :bite_id
      t.integer :photo_id
      t.timestamps
    end
  end

  def self.down
    drop_table :bites_photos
  end
end