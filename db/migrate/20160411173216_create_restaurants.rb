class CreateRestaurants < ActiveRecord::Migration
  def change
    # a restaurant table
    create_table :restaurants do |t|
      t.string :name, null: false # name cannot be null
      t.string :distance
      t.string :cuisine
      t.string :cost
      t.timestamps null: false
    end
  end
end
