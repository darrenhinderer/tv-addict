class CreateShows < ActiveRecord::Migration
  def self.up
    create_table :shows do |t|
      t.string :name
      t.boolean :on_air
      t.string :hulu_url

      t.timestamps
    end
  end

  def self.down
    drop_table :shows
  end
end
