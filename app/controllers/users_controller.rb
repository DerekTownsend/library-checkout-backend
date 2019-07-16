class UsersController < ApplicationController
  def index
    user = User.all
    render json: UserSerializer.new(user).to_serialized_json
  end

  def show
    user = User.find_by(id: params[:id])
    render json: UserSerializer.new(user).to_serialized_json
  end

  def login
    user = User.find_by(username: params[:username])
    if user
      render json: UserSerializer.new(user).to_serialized_json
    else
      render json: {message: "failure"}
    end
  end

  def checkout
    user = User.find_by(id: params[:user_id])
    library_item = LibraryItem.find_by(id: params[:library_item_id])

    checkout_date = DateTime.now.strftime("%d/%m/%Y")
    return_date = (DateTime.now + 6.months).strftime("%d/%m/%Y")

    library_item.update_attributes(checkout_date: checkout_date, return_date: return_date)

    user.library_items << library_item;

    render json: UserSerializer.new(user).to_serialized_json
  end

  def return
    user = User.find_by(id: params[:user_id])
    library_item = LibraryItem.find_by(id: params[:library_item_id])
    library_item.update_attributes(checkout_date: nil, return_date: nil)

    user.library_items.delete(library_item)

    render json: UserSerializer.new(user).to_serialized_json
  end
  
end
