class CreateBites < ActiveRecord::Migration
  def self.up
    create_table :bites do |t|
      t.string :url
      t.string :image_url

      t.timestamps
    end
  end

  def self.down
    drop_table :bites
  end
end
