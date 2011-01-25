class CreateVotesTable < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :user_id
      t.integer :link_id
      t.integer :value

      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
