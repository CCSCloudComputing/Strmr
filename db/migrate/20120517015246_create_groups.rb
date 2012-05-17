class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :title
      t.string :password_digest
      t.string :gid
      t.timestamps
    end
  end
end
