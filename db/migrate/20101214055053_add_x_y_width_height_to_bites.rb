class AddXYWidthHeightToBites < ActiveRecord::Migration
  def self.up
    add_column :bites, :top, :string
    add_column :bites, :left, :string
    add_column :bites, :width, :string
    add_column :bites, :height, :string
  end

  def self.down
    remove_column :bites, :top
    remove_column :bites, :left
    remove_column :bites, :width
    remove_column :bites, :height
  end
end
