class BooksController < ApplicationController
  def index
    books = Book.all
    render json: ObjectSerializer.new(books).to_serialized_json
  end

  def show
    book = Book.find_by(id: params[:id])
    render json: ObjectSerializer.new(book).to_serialized_json
  end

  def create
    book = Book.create(book_params)
    libraryItem = LibraryItem.new(book_params[:library_item_attributes])
    libraryItem.assign_attributes(libraryable: book)

    render json: LibraryItemSerializer.new(book.library_item).to_serialized_json
  end

  def update
    book = Book.find_by(id: params[:id])
    # THIS "WORKS"
    # book.library_item.update_attributes(book_params[:library_item_attributes])
    # book.update_attributes(book_params)

    book.author = book_params[:author]
    book.volume = book_params[:volume]
    book.library_item.attributes = book_params[:library_item_attributes]
    book.save

    render json: LibraryItemSerializer.new(book.library_item).to_serialized_json
  end

  def destroy
    Book.find_by(id: params[:id]).destroy
    render json: {message: "success"}
  end
private
  def book_params
    params.require(:book).permit(:author, :volume, library_item_attributes: [:name, :description, :publisher, :url])
  end

end
