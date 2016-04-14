class HomeController < ApplicationController
  def index
    @cuisines = Restaurant.select(:cuisine).distinct.map(&:cuisine) # {|r| r.cuisine } == (&:cuisine)
    @distances = Restaurant.select(:distance).distinct.map(&:distance) # {|r| r.cuisine } == (&:cuisine)
    @costs = Restaurant.select(:cost).distinct.map(&:cost) # {|r| r.cuisine } == (&:cuisine)

    # That one line eliminates all this!
    # The db can do things better than ruby, ruby is slower. Those algorithms below are not as good as the DB)
    # @restaurants = Restaurant.all
    # @restaurants.select
    # @cuisines = []
    # @restaurants.each do |c|
    #    @cuisines << c.cuisine
    # end
    # @cuisines = @cuisines.uniq
  end


  # Picks restaurant randomly for you.
  # TODO add filters for Distance and Cuisine
  def pick_for_me
    @picked = true
    @restaurant = Restaurant.offset(rand(Restaurant.count)).first
  end

  #def cuisines
  #  @cuisines = @restaurants.cuisine.all
  #  @cuisines = @cuisines.uniq
  #end
end

# <p class="lead">You will be dining with the fine people at:</p>
#   <hr>
#   <p><%= @restaurant.name %></p>