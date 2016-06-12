class AddDraftHidden < ActiveRecord::Migration
  def self.up
    add_column :papers, :draft, :boolean
    add_column :papers, :hidden, :boolean
  end

  def self.down
    remove_column :papers, :draft
    remove_column :papers, :hidden
  end
end
