class ConferenceProceedingsController < ApplicationController
  def index
    conference_proceedings = ConferenceProceeding.all
    render json: ObjectSerializer.new(conference_proceedings).to_serialized_json
  end

  def show
    conference_proceeding = ConferenceProceeding.find_by(id: params[:id])
    render json: ObjectSerializer.new(conference_proceeding).to_serialized_json
  end

  def create
    conference_proceeding = ConferenceProceeding.create(conference_proceeding_params)
    libraryItem = LibraryItem.new(conference_proceeding_params[:library_item_attributes])
    libraryItem.assign_attributes(libraryable: conference_proceeding)

    render json: LibraryItemSerializer.new(conference_proceeding.libraryItem).to_serialized_json
  end

  def update
    conference_proceeding = ConferenceProceeding.find_by(id: params[:id])
    # THIS "WORKS"
    # conference_proceeding.library_item.update_attributes(conference_proceeding_params[:library_item_attributes])
    # conference_proceeding.update_attributes(conference_proceeding_params)

    conference_proceeding.editor = conference_proceeding_params[:editor]
    conference_proceeding.date = conference_proceeding_params[:date]
    conference_proceeding.location = conference_proceeding_params[:location]
    # puts "ARE YOU DELETING HERE 1"
    conference_proceeding.library_item.attributes = conference_proceeding_params[:library_item_attributes]
    # puts "ARE YOU DELETING HERE 2"

    conference_proceeding.save

    render json: LibraryItemSerializer.new(conference_proceeding.library_item).to_serialized_json
  end

  def destroy
    ConferenceProceeding.find_by(id: params[:id]).destroy
    render json: {message: "success"}
  end
private
  def conference_proceeding_params
    params.require(:conference_proceeding).permit(:editor, :date, :location, library_item_attributes: [:name, :description, :publisher, :url])
  end
end
