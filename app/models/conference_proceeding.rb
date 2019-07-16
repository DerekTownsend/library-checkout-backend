class ConferenceProceeding < ApplicationRecord
  has_one :library_item, as: :libraryable, :dependent => :destroy, :autosave => true
  accepts_nested_attributes_for :library_item

end
