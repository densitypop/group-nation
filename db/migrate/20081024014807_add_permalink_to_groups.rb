class AddPermalinkToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, 'permalink', :string
  end

  def self.down
    remove_column :groups, 'permalink'
  end
end
