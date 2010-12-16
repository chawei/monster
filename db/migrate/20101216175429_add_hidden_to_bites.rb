class AddHiddenToBites < ActiveRecord::Migration
  def self.up
    add_column :bites, :hidden, :boolean
  end

  def self.down
    remove_column :bites, :hidden
  end
end
