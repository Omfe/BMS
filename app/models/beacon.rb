class Beacon < ActiveRecord::Base
  belongs_to :owner
  
  validates :name, :factory_id, presence: true
  
  def self.search(search, owner_id)
    if search
      #joins(:owner).where('name LIKE ? or owners.id LIKE ?', "%#{search}%", "%#{owner_id}%")
      where('name LIKE ? AND owner_id = ?', "%#{search}%", "#{owner_id}")
    else
      where(nil)
    end
  end
end
