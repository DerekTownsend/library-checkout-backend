class LibraryItem < ApplicationRecord
  # has_one :magazine
  # has_one :journal
  # has_many :users, through: :reservations
  # has_many :users, through: :reservations, as: :reserved_users
  has_many :reservations, :dependent => :destroy, :autosave => true
  has_many :reserved_users, through: :reservations, :source => :user

  belongs_to :user, optional: true
  belongs_to :libraryable, polymorphic: true
end
