class AddArticleNumber < ActiveRecord::Migration
  def self.up
    add_column :papers, :article_number, :string
  end

  def self.down
    remove_column :papers, :article_number
  end
end
