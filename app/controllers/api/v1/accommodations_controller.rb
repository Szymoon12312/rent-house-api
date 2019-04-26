class Api::V1::AccommodationsController < ApplicationController

  def index
    data = Accommodation.page params[:page]
    render_success(data, Api::AccommodationSerializer)
  end

  def show
    data = Accommodation.find(params[:id])
    render_success(data, Api::AccommodationSerializer)
  end

  def create
    current_user = User.first
    accommodation = Accommodations::CreateService.call(current_user, accommodation_params)
    render_success(accommodation, Api::AccommodationSerializer)
  end

  private

  def accommodation_params
    params.require(:data).permit!
  end

end
