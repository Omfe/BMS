class Beacon < ActiveRecord::Base
  belongs_to :owner
  
  validates :name, :factory_id, presence: true
end
