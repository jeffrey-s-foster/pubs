class Paper < ActiveRecord::Base
  has_and_belongs_to_many :tags

  attr_accessor :month_other
  attr_accessor :tag_list
end
