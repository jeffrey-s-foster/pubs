class ChangePageNumTypesAgain < ActiveRecord::Migration
  def self.up
    change_column :papers, :page_start, :string
    change_column :papers, :page_end, :string
  end

  def self.down
  end
end
