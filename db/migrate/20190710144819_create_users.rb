class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :address
      t.references :userable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
