class BookingsController < ApplicationController
  before_action :set_booking, only: [:destroy]
  before_action :ensure_owner, only: [:destroy]

  respond_to :html

  def index
    @bookings = Booking.all
    respond_with(@bookings)
  end

  def new
    @booking = Booking.new
    respond_with(@booking)
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = current_user.id
    if @booking.save
      redirect_to bookings_url, alert: "Your booking was created successfully"
    else
      respond_with(@booking)
    end
  end

  def destroy
    @booking.destroy
    respond_with(@booking)
  end

  private
    def set_booking
      @booking = Booking.find(params[:id])
    end

    def ensure_owner
      unless @booking.user == current_user
        redirect_to bookings_url, alert: "You can only modify your own bookings!"
      end
    end

    def booking_params
      params.require(:booking).permit(:user_id, :time)
    end
end
