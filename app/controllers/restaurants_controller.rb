class RestaurantsController < ApplicationController
  #Lists all Restaurants
  def index
    @restaurants = Restaurant.all
  end

  # Shows the current restaurant
  def show
    @restaurant = Restaurant.find(params[:id])
  end

  # Displays the new restaurant form page
  def new
  end

  # Handles Saving a new restaurant. Redirects the page to the restaurant's show page
  def create
    @restaurant = Restaurant.new(restaurant_params)

    @restaurant.save
    redirect_to @restaurant
  end

  private

  # Strong Params. We could just grab them all with params[:restaurant] but that would
  # open it up to malicious acts. So, we make sure only to grab the ones that matter, in
  # this case, :name
  # Making it private further encapsulates and protects the method from outside influence
  def restaurant_params
    params.require(:restaurant).permit(:name)
  end
end
