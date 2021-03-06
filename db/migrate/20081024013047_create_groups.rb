class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups, :force => true do |t|
      t.string :name
      t.integer :organizer_id
      t.string :city
      t.string :state
      t.string :zip
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
