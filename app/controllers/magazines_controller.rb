class MagazinesController < ApplicationController
  def index
    magazines = Magazine.all
    render json: ObjectSerializer.new(magazines).to_serialized_json
  end

  def show
    magazine = Magazine.find_by(id: params[:id])
    render json: ObjectSerializer.new(magazine).to_serialized_json
  end

  def create
    magazine = Magazine.create(magazine_params)
    libraryItem = LibraryItem.new(magazine_params[:library_item_attributes])
    libraryItem.assign_attributes(libraryable: magazine)

    render json: LibraryItemSerializer.new(magazine.libraryItem).to_serialized_json
  end

  def update
    magazine = Magazine.find_by(id: params[:id])
    # THIS "WORKS"
    # magazine.library_item.update_attributes(magazine_params[:library_item_attributes])
    # magazine.update_attributes(magazine_params)

    magazine.date_of_pub = magazine_params[:date_of_pub]
    magazine.type_of_mag = magazine_params[:type_of_mag]
    magazine.library_item.attributes = magazine_params[:library_item_attributes]
    magazine.save

    render json: LibraryItemSerializer.new(magazine.library_item).to_serialized_json
  end

  def destroy
    Magazine.find_by(id: params[:id]).destroy
    render json: {message: "success"}
  end

private

  def magazine_params
    params.require(:magazine).permit(:date_of_pub, :type_of_mag, library_item_attributes: [:name, :description, :publisher, :url])
  end
end
