class JournalsController < ApplicationController
  def index
    journals = Journal.all
    render json: ObjectSerializer.new(journals).to_serialized_json
  end

  def show
    journal = Journal.find_by(id: params[:id])
    render json: ObjectSerializer.new(journal).to_serialized_json
  end

  def create
    journal = Journal.create(journal_params)
    libraryItem = LibraryItem.new(journal_params[:library_item_attributes])
    libraryItem.assign_attributes(libraryable: journal)

    render json: LibraryItemSerializer.new(journal.libraryItem).to_serialized_json
  end

  def update
    journal = Journal.find_by(id: params[:id])
    # THIS "WORKS"
    # journal.library_item.update_attributes(journal_params[:library_item_attributes])
    # journal.update_attributes(journal_params)

    journal.number = journal_params[:number]
    journal.library_item.attributes = journal_params[:library_item_attributes]
    journal.save

    render json: LibraryItemSerializer.new(journal.library_item).to_serialized_json
  end

  def destroy
    Journal.find_by(id: params[:id]).destroy
    render json: {message: "success"}
  end

private
  def journal_params
    params.require(:journal).permit(:number, library_item_attributes: [:name, :description, :publisher, :url])
  end
end
