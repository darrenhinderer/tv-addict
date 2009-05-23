class AddTvdbFields < ActiveRecord::Migration
  def self.up
    add_column :shows, :tvdb_id, :integer
    add_column :shows, :series_id, :integer
    add_column :shows, :imdb_url, :string
    add_column :shows, :banner_url, :string
    add_column :shows, :overview, :string
    remove_column :shows, :hulu_url
    remove_column :shows, :on_air
  end

  def self.down
  end
end
