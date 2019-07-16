class LibraryItemsController < ApplicationController
  def index
    library_items = LibraryItem.all
    # render json: library_items, only: [:type]

    render json: LibraryItemSerializer.new(library_items).to_serialized_json
  end
end
