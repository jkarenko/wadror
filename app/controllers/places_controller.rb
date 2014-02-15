class PlacesController < ApplicationController
  def index
  end

  def search
    session[:last_searched_city] = params[:city]
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def show
    @place = BeermappingApi.places_in(session[:last_searched_city]).find { |x| x.id == params[:id] }
  end
end