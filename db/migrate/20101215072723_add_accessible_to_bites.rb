class AddAccessibleToBites < ActiveRecord::Migration
  def self.up
    add_column :bites, :accessible, :boolean
  end

  def self.down
    remove_column :bites, :accessible
  end
end
