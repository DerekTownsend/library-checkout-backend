class CreateLibraryItem < ActiveRecord::Migration[5.2]
  def change
    create_table :library_items do |t|
      t.string :publisher
      # t.string :title
      t.string :url
      t.string :name
      t.text :description
      # t.references :imageable, polymorphic: true, index: true

      # type of book
      # t.string :type

      # Magazines
      # t.string :brand_name
      # t.string :type_of_mag
      # t.date :date_of_pub

      #journals
      # t.integer :number
      # t.string :title

      t.date :checkout_date
      t.date :return_date

      t.references :libraryable, polymorphic: true, index: true


      t.timestamps
    end
  end
end
