class V1::BookingsController < ApiBaseController
  before_action :authorize_seller!, only: [:seller_index]
  before_action :authorize_buyer!, only: [:buyer_index]
  before_action :set_v1_booking, only: [:show, :update, :destroy]

  # GET /v1/bookings
  # GET /v1/bookings.json
  def seller_index
    @v1_bookings = V1::Booking.where('quotation_id in ? OR deal_id in ?', V1::Quo).
    render json: @v1_bookings
  end

  def buyer_index
    render json: @v1_bookings
  end

  # GET /v1/bookings/1
  # GET /v1/bookings/1.json
  def show
    render json: @v1_booking
  end

  # POST /v1/bookings
  # POST /v1/bookings.json
  def create
    @v1_booking = V1::Booking.new(buyer_booking_params)

    if @v1_booking.save
      render json: @v1_booking, status: :created
    else
      render json: @v1_booking.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/bookings/1
  # PATCH/PUT /v1/bookings/1.json
  def update
    if @v1_booking.update(buyer_booking_params)
      head :no_content
    else
      render json: @v1_booking.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/bookings/1
  # DELETE /v1/bookings/1.json
  def destroy
    @v1_booking.destroy
    head :no_content
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_v1_booking
    @v1_booking = V1::Booking.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def buyer_booking_params
    params.require(:booking).permit(:quote_id, :outlet_id)
  end
end
