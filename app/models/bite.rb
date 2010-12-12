class Bite < ActiveRecord::Base
  
  def normalized_image_url
    if self.image_url =~ /^http/
      return self.image_url
    elsif match = self.image_url.match(/^\/.*/)
      new_image_url = match[0]
      uri = URI(self.url)
      return "http://#{uri.host}#{new_image_url}"
    else 
      if match = self.image_url.match(/^\w.*/)
        new_image_url = match[0]
      end
      uri = self.url.match(/(.*\/)/)[0]
      return "#{uri}#{new_image_url}"
    end
  end
  
end
