class AddGidIndexToGroups < ActiveRecord::Migration
  def change
    add_index :groups, :gid, :unique => true
  end
end
