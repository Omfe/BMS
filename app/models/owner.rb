class Owner < ActiveRecord::Base
  has_many :beacons
  validates :name, presence: true
end
