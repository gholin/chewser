class Restaurant < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 30 }
  validates :cuisine, length: { maximum: 30 }
end
