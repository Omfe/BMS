class Owner < ActiveRecord::Base
  has_many :beacons
  mount_uploader :image, ImageUploader
  validates :name, presence: true
  VALID_NAMES = %w(Company Event)
  validates_inclusion_of :owner_type, :in => VALID_NAMES
  
  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      where(nil)
    end
  end
  
  def self.gimbal_get_beacon(beacon)
    uri = URI.parse("https://manager.gimbal.com/api/beacons/#{beacon.factory_id}")
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Get.new(uri.path, initheader = {'Content-Type' =>'application/json'})
    req['AUTHORIZATION'] = 'Token token=8a4a400252a9b0dc3a76130de89e9522'
    res = https.request(req)
    return res
  end
end
