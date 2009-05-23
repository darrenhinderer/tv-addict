class CreateResponses < ActiveRecord::Migration
  def self.up
    create_table :responses do |t|
      t.string "status"
      t.integer "facebook_user_id"
      t.integer "show_id"
      t.timestamps
    end
  end

  def self.down
    drop_table :responses
  end
end
