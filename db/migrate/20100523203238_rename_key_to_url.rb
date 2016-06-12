class RenameKeyToUrl < ActiveRecord::Migration
  def self.up
    rename_column :papers, :key, :url
  end

  def self.down
    rename_column :papers, :url, :key
  end
end
