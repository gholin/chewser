class HomeController < ApplicationController
  def index
    init
    render_msg
  end

  private

  # Gathers all data needed for picking a restaurant, including filters
  def init
    # grab only the attributes that exist to populate the filters
    @cuisines = Restaurant.select(:cuisine).distinct.map(&:cuisine) # {|r| r.cuisine } == (&:cuisine)
    @distances = Restaurant.select(:distance).distinct.map(&:distance) # {|r| r.cuisine } == (&:cuisine)
    @costs = Restaurant.select(:cost).distinct.map(&:cost) # {|r| r.cuisine } == (&:cuisine)

    @selected_cuisine = params[:cuisine] if params[:cuisine]
    @selected_distance = params[:distance] if params[:distance]
    @selected_cost = params[:cost] if params[:cost]

    # gets all the restaurants
    @restaurants = Restaurant.all
  end

  # Renders the restaurant picking
  def render_msg
    @msg = ''
    if @restaurants.count == 0
      @error_msg = "You haven't created any restaurants yet!"
    else
      if params[:cuisine].present?
        filter
      else
        @error_msg = "You haven't picked any restaurants yet!"
      end
    end
  end

  def filter
    filter_parameters = gather_filters

    query_with_filters(filter_parameters)

    pick_restaurant
  end

  def pick_restaurant
    if @filtered.empty?
      @restaurant = Restaurant.offset(rand(Restaurant.count)).first
      @msg = "None matched, but I picked another for you at random: #{@restaurant.name}"
    else
      @msg = @filtered.sample.name
    end
  end

  def query_with_filters(filter_parameters)
    @filtered = Restaurant.where(filter_parameters)
  end

  def gather_filters
    filter_parameters = {}
    [:cuisine, :cost, :distance].each do |filter|
      filter_parameters[filter] = params[filter] if params[filter] != 'Any'
    end

    # filter_parameters[:cuisine] = params[:cuisine] if params[:cuisine] != 'Any'
    # filter_parameters[:cost] = params[:cost] if params[:cost] != 'Any'
    # filter_parameters[:distance] = params[:distance] if params[:distance] != 'Any'

    filter_parameters
  end
end