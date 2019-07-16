class User < ApplicationRecord
  belongs_to :userable, polymorphic: true
  has_many :library_items, :autosave => true
  has_many :reservations, :dependent => :destroy, :autosave => true
  has_many :reserved_books, through: :reservations, :source => :library_item
  # , :foreign_key => :library_item_id

end
