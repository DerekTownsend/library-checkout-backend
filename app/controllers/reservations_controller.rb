class ReservationsController < ApplicationController
  def create
    reservation = Reservation.create(reservation_params)
    # reservation.user
    render json: UserSerializer.new(reservation.user).to_serialized_json
  end

  def destroy
    reservation = Reservation.find(params[:id])
    user = reservation.user
    reservation.destroy

    render json: UserSerializer.new(user).to_serialized_json
  end

private
  def reservation_params
    params.require(:reservation).permit(:user_id, :library_item_id)
  end
end
