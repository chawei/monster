class AddDomainNameToBites < ActiveRecord::Migration
  def self.up
    add_column :bites, :domain_name, :string
  end

  def self.down
    remove_column :bites, :domain_name
  end
end
