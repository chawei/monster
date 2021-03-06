class Bite < ActiveRecord::Base
  has_and_belongs_to_many :photos
  
  scope :accessible, :conditions => { :accessible => true }
  scope :unaccessible, :conditions => { :accessible => false }
  scope :visible, :conditions => ["hidden is NULL or hidden = ?", false ]
  
  validates :url, :presence => true
  validates :image_url, :presence => true
  
  before_create :set_accessible
  before_save   :get_domain_name
  after_create  :create_photo_by_image_url
  
  def self.admin_photos
    accessible.order('created_at DESC').limit(300)
  end
  
  def self.without_photo
    joins("LEFT OUTER JOIN bites_photos ON bites_photos.bite_id = bites.id").
    where("bites_photos.photo_id IS NULL")
  end
  
  def self.today
    date = Date.today
    return public_facing.includes(:photos).on(date).order('bites.created_at DESC')
  end
  
  def self.public_on(date)
    public_facing.on(date).order('bites.created_at DESC').includes(:photos)
  end
  
  def self.public_facing
    visible.accessible
  end
  
  def self.on(date)
    where(:created_at => (date)..(date+1.day))
  end
  
  def self.top_20_sources_in_hash
    top_sources.limit(20).map { |b| [b.domain_name, b.cnt] }
  end
  
  def self.top_sources_on(date)
    top_sources.on(date)
  end
  
  def self.top_sources
    select("count(*) as cnt, domain_name").
    public_facing.group("domain_name").
    order("cnt DESC")
  end
  
  def self.count_on(date)
    public_facing.on(date).count
  end
  
  def self.all_count
    public_facing.count
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
    return '' if self.image_url.blank?
    
    if self.image_url =~ /^http/
      return self.image_url
    elsif match = self.image_url.match(/^[\/][^\/].*/)
      new_image_url = match[0]
      uri = URI(self.url)
      return "http://#{uri.host}#{new_image_url}"
    # //d6kwnbvhrfby3.cloudfront.net/img/donate/donate.png
    elsif match = self.image_url.match(/^\/\/(.*)/)
      new_image_url = match[1]
      return "http://#{new_image_url}"
    elsif match = self.image_url.match(/^[\w].*/)
      return "#{self.url}/#{match[0]}"
    else
      return self.image_url
    end
  end
  
  def self.for_exhibition(date)
    top_sources = top_sources_on(date).limit(10).map { |b| { 'domain_name' => b.domain_name, 'count' => b.cnt } }
    results = { 'top_sources' => top_sources, 'bites' => [] }
    
    bites = on(date).limit(150)
    bites.each do |bite|
      if bite.photo
        result = { 'id' => "bite-#{bite.id}", "image_html" => "<img src='#{bite.photo.data.url(:thumb)}' />" }
        results['bites'] << result
      end
    end
    return results
  end
  
  protected
  
    def set_accessible
      begin
        res = HTTParty.get(URI.escape(self.normalized_image_url))
        res.code == 200 ? self.accessible = true : self.accessible = false
      rescue
        self.accessible = false
      end
      nil
    end
end
