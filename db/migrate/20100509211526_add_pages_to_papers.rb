class AddPagesToPapers < ActiveRecord::Migration
  def self.up
    add_column :papers, :page_start, :integer
    add_column :papers, :page_end, :integer
  end

  def self.down
    remove_column :papers, :page_end
    remove_column :papers, :page_start
  end
end
