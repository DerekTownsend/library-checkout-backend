class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :user, foreign_key: true
      t.references :library_item, foreign_key: true

      t.timestamps
    end
  end
end
