class RenameAuthorIdToUserIdInLinks < ActiveRecord::Migration
  def self.up
    rename_column :links, :author_id, :user_id
  end

  def self.down
    rename_column :links, :user_id, :author_id
  end
end
