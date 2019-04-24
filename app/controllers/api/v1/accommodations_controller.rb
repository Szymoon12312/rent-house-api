class Api::V1::AccommodationsController < ApplicationController
  def index
    data = Accommodation.page params[:page]
    render_success data.as_json(:include => [:location,:price])
  end

  def show
    data = Accommodation.find(accommodation_params[:id])
    render_success data.as_json(:include => [:location,:price,:accommodation_property])
  end

  private

  def accommodation_params
    params.permit(:id,:page)
  end

end
