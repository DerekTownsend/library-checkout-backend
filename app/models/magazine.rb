class Magazine < ApplicationRecord
  # self.table_name = :magazines
  # belongs_to :library_item
  # has_one :library_item
  has_one :library_item, as: :libraryable, :dependent => :destroy, :autosave => true
  accepts_nested_attributes_for :library_item

  # has_many :library_items, as: :library_itemable


end
