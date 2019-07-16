class CreateConferenceProceedings < ActiveRecord::Migration[5.2]
  def change
    create_table :conference_proceedings do |t|
      t.string :location
      t.date :date
      t.string :editor

      t.timestamps
    end
  end
end
