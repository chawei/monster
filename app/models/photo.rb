class Photo < ActiveRecord::Base
  has_and_belongs_to_many :bites
  
  has_attached_file :data, :styles => { :medium => "500x500>", 
                                        :thumb => "60x60#" },
                           :storage => :s3, 
                           :s3_credentials => {
                             :access_key_id => S3[:key],
                             :secret_access_key => S3[:secret] },
                           :bucket => S3[:bucket],
                           :path => "photos/:id/:style.:extension",
                           :default_url => "/images/s3/photos/default_:style.png"
  
  before_create :download_remote_image
                         
  def download_remote_image
    if self.original_url
      self.data = do_download_remote_image
    end
  end
  
  def download_remote_image!
    download_remote_image
    self.save
  end
  
  private
  
    def do_download_remote_image
      io = open(URI.parse(original_url))
      return nil unless ['image/jpeg', 'image/png', 'image/gif'].include? io.content_type
      
      def io.original_filename; base_uri.path.split('/').last; end
      io.original_filename.blank? ? nil : io
    rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
      return nil
    end
end
