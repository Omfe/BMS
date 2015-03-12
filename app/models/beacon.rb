class Beacon < ActiveRecord::Base
  belongs_to :owner
  validates :name, :factory_id, :latitude, :longitude, presence: true
  require 'uri'
  require 'net/http'
  require 'net/https'
  
  def self.search(search, owner_id)
    if search
      #joins(:owner).where('name LIKE ? or owners.id LIKE ?', "%#{search}%", "%#{owner_id}%")
      where('name LIKE ? AND owner_id = ?', "%#{search}%", "#{owner_id}")
    else
      where(nil)
    end
  end
  
  def self.gimbal_create_beacon(beacon)
    @toSend = {
        "factory_id" => "#{beacon.factory_id}",
        "name" => "#{beacon.name}",
        "latitude" => "#{beacon.latitude}",
        "longitude" => "#{beacon.longitude}"
    }.to_json

    uri = URI.parse("https://manager.gimbal.com/api/beacons")
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
    req['AUTHORIZATION'] = 'Token token=8a4a400252a9b0dc3a76130de89e9522'
    req.body = " #{@toSend} "
    puts "#{req.body}"
    res = https.request(req)
    puts "Response #{res.code} #{res.message}: #{res.body}"
    return res.code
  end
  
  def self.gimbal_update_beacon(beacon)
    @toSend = {
        "name" => "#{beacon.name}",
        "latitude" => "#{beacon.latitude}",
        "longitude" => "#{beacon.longitude}"
    }.to_json

    uri = URI.parse("https://manager.gimbal.com/api/beacons/#{beacon.factory_id}")
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Put.new(uri.path, initheader = {'Content-Type' =>'application/json'})
    req['AUTHORIZATION'] = 'Token token=8a4a400252a9b0dc3a76130de89e9522'
    req.body = " #{@toSend} "
    puts "#{req.body}"
    res = https.request(req)
    puts "Response #{res.code} #{res.message}: #{res.body}"
    return res.code
  end
  
  def self.gimbal_delete_beacon(beacon)
    uri = URI.parse("https://manager.gimbal.com/api/beacons/#{beacon.factory_id}")
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Delete.new(uri.path, initheader = {'Content-Type' =>'application/json'})
    req['AUTHORIZATION'] = 'Token token=8a4a400252a9b0dc3a76130de89e9522'
    #req.body = " #{@toSend} "
    #puts "#{req.body}"
    res = https.request(req)
    return res.code
  end
end
