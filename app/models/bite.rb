class Bite < ActiveRecord::Base
  has_and_belongs_to_many :photos
  
  scope :accessible, :conditions => { :accessible => true }
  scope :visible, :conditions => ["hidden is NULL or hidden = ?", false ]
  
  before_create :set_accessible
  before_save   :get_domain_name
  
  def self.without_photo
    joins("LEFT OUTER JOIN bites_photos ON bites_photos.bite_id = bites.id").where("bites_photos.photo_id IS NULL")
  end
  
  def self.today
    date = Date.today
    return on(date)
  end
  
  def self.on(date)
    return visible.accessible.where(:created_at => (date)..(date+1.day)).order('created_at DESC')
  end
  
  def self.top_sources_on(date)
    select("count(*) as cnt, domain_name").visible.accessible.where(:created_at => (date)..(date+1.day)).group("domain_name").order("cnt DESC")
  end
  
  def self.top_sources
    select("count(*) as cnt, domain_name").visible.accessible.group("domain_name").order("cnt DESC")
  end
  
  def self.count_on(date)
    visible.accessible.where(:created_at => (date)..(date+1.day)).count
  end
  
  def get_domain_name
    begin
      uri = URI.parse(URI.encode(self.url))
      self.domain_name = uri.host
    rescue
      puts "Error when parsing ID: #{self.id} URL: #{self.url}"
    end
  end
  
  def photo
    photos.first
  end
  
  def create_photo_by_image_url
    photo = Photo.create(:original_url => self.normalized_image_url)
    if photo && photo.data.exists?
      self.photos << photo
    else
      photo.destroy
      self.accessible = false
      self.save
    end  
  end
  
  def normalized_image_url
    if self.image_url =~ /^http/
      return self.image_url
    elsif match = self.image_url.match(/^\/.*/)
      new_image_url = match[0]
      uri = URI(self.url)
      return "http://#{uri.host}#{new_image_url}"
    else 
      if match = self.image_url.match(/^[\.\w].*/)
        new_image_url = match[0]
      end
      uri = self.url.match(/(.*\/)/)[0]
      return "#{uri}#{new_image_url}"
    end
  end
  
  protected
  
    def set_accessible
      res = HTTParty.get(URI.escape(self.normalized_image_url))
      res.code == 200 ? self.accessible = true : self.accessible = false
    end
end
