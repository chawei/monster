class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :original_url
      t.string :data_file_name
      t.integer :data_file_size
      t.string :data_content_type
      t.datetime :data_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
