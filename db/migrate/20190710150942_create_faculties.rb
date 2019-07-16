class CreateFaculties < ActiveRecord::Migration[5.2]
  def change
    create_table :faculties do |t|
      t.integer :years_of_service

      t.timestamps
    end
  end
end
