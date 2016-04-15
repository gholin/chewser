# Used to handle logic to show someone's pick depending on if a restaurant exists or not
class PickDecorator
  def initialize(restaurant, count)
    @restaurant = restaurant
    @count = count
  end

  def message
    if @restaurant.nil?
      "no restaurants available"
    else
      "#{@restaurant.name} picked from #{@count} possibilities"
    end
  end
end
