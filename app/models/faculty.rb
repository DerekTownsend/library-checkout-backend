class Faculty < ApplicationRecord
  has_one :user, as: :userable, :dependent => :destroy, :autosave => true
  accepts_nested_attributes_for :user

end
