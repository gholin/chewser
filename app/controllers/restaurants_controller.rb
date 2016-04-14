class RestaurantsController < ApplicationController
  before_filter :check_for_cancel, :only => [:create, :update]

  #Lists all Restaurants on the Manage Restaurants page
  def index
    @restaurants = Restaurant.all
  end

  # Shows the current restaurant
  def show
    @restaurant = Restaurant.find(params[:id])
  end

  # Displays the new restaurant form page and initializes a default restaurant instance to avoid nil references
  # to the variable (avoid errors specifically in the validation logic in adding new restaurants)
  def new
    @restaurant = Restaurant.new
  end

  # Gives you the id for the restaurant you want to edit. Helps you get to that page.
  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  # Updates restaurant
  def update
    @restaurant = Restaurant.find(params[:id])

    respond_to do |format|
      if @restaurant.update(restaurant_params)
        flash[:success] = 'Restaurant successfully updated!'
        format.html { redirect_to restaurants_path}
        format.json { render :show, status: :ok, location: restaurants_path }
      else
        flash[:danger] = "Error(s) updating restaurant: #{@restaurant.errors.full_messages}"
        format.html { render :edit }
        format.json { render json: @restaurants.errors, status: :unprocessable_entity }
      end
    end
  end

  # Handles Saving a new restaurant. Redirects the page to the restaurant's show page
  def create
    @restaurant = Restaurant.new(restaurant_params)
    respond_to do |format|
      if @restaurant.save
        flash[:success] = 'Restaurant successfully created!'
        format.html { redirect_to restaurants_path}
        format.json { render :show, status: :created, location: restaurants_path }
      else
        flash[:danger] = "Error(s) creating restaurant: #{@restaurant.errors.full_messages}"
        format.html { render :new }
        format.json { render json: @restaurants.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])

    if @restaurant.destroy
      respond_to do |format|
        flash[:success] = 'Restaurant successfully removed!'
        format.html { redirect_to restaurants_path }
      end
    else
      flash[:danger] = "Error(s) removing restaurant: #{@restaurant.errors.full_messages}"
      format.html { redirect_to restaurants_path }
    end
  end

  #TODO implement an "are you sure" dialog, this is something rails has built in. Find it!
  def nukem_all
    Restaurant.destroy_all
    redirect_to restaurants_path
  end

  # Checks for canceling a creation or update to a form
  def check_for_cancel
    if(params.key?("cancel"))
      redirect_to restaurants_path
    end
  end

  private

  # Strong Params. We could just grab them all with params[:restaurant] but that would
  # open it up to malicious acts. So, we make sure only to grab the ones that matter, in
  # this case, :name
  # Making it private further encapsulates and protects the method from outside influence
  def restaurant_params
    params.require(:restaurant).permit(:name, :distance, :cuisine, :cost)
  end
end
