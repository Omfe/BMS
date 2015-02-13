class Owner < ActiveRecord::Base
  has_many :beacons
  validates :name, presence: true
  VALID_NAMES = %w(Company Event)
  validates_inclusion_of :owner_type, :in => VALID_NAMES
  #validates_inclusion_of :image, :in => %w( jpg gif png ), :message => "extension %s is not included in the list"
end
