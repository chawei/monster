class Bite < ActiveRecord::Base
  
  scope :accessible, :conditions => { :accessible => true }
  
  before_save :set_accessible
  
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
