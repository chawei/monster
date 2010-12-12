class Bite < ActiveRecord::Base
  
  def normalized_image_url
    if self.image_url =~ /^\//
      uri = URI(self.url)
      return "http://#{uri.host}#{self.image_url}"
    else
      return self.image_url
    end
  end
  
end
