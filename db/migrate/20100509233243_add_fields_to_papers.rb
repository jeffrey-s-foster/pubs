class AddFieldsToPapers < ActiveRecord::Migration
  def self.up
    add_column :papers, :address, :string
    add_column :papers, :author, :string
    add_column :papers, :booktitle, :string
    add_column :papers, :editor, :string
    add_column :papers, :institution, :string
    add_column :papers, :journal, :string
    add_column :papers, :key, :string
    add_column :papers, :month, :string
    add_column :papers, :note, :string
    add_column :papers, :num_accepted, :integer
    add_column :papers, :num_submitted, :integer
    add_column :papers, :number, :string
    add_column :papers, :organization, :string
    add_column :papers, :publisher, :string
    add_column :papers, :series, :string
    add_column :papers, :volume, :string
  end

  def self.down
    remove_column :papers, :volume
    remove_column :papers, :series
    remove_column :papers, :publisher
    remove_column :papers, :organization
    remove_column :papers, :number
    remove_column :papers, :num_submitted
    remove_column :papers, :num_accepted
    remove_column :papers, :note
    remove_column :papers, :month
    remove_column :papers, :key
    remove_column :papers, :journal
    remove_column :papers, :institution
    remove_column :papers, :editor
    remove_column :papers, :booktitle
    remove_column :papers, :author
    remove_column :papers, :address
  end
end
