class AddSchool < ActiveRecord::Migration
    add_column :papers, :school, :string

  def self.down
    remove_column :papers, :school
  end
end
