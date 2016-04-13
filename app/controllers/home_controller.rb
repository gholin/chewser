class HomeController < ApplicationController
  def index
  end

  def pick_for_me
    @restaurant = Restaurant.offset(rand(Restaurant.count)).first
  end
end
