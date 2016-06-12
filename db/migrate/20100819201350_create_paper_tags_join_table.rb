class CreatePaperTagsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :papers_tags, :force => true, :id => false do |t|
      t.integer :paper_id
      t.integer :tag_id
    end
  end

  def self.down
    drop_table :papers_tags
  end
end
