class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :library_item
end
