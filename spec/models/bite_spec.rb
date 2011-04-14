require 'spec_helper'

describe Bite do
  setup do
    Photo.any_instance.stubs(:save_attached_files).returns(true)
    Photo.any_instance.stubs(:delete_attached_files).returns(true)
    Paperclip::Attachment.any_instance.stubs(:post_process).returns(true)
  end
    
  it { should have_and_belong_to_many :photos }
  
  context "accessible" do
    it "should return accessible bites" do
      bite = Factory(:bite, :image_url => "http://invalid.url")
      Bite.accessible.should_not include bite
    end
  end
  
  context "visible" do
    it "should return visible bites" do
      default_bite = Factory(:bite)
      Bite.visible.should include default_bite
      
      hidden_bite = Factory(:bite, :hidden => true)
      Bite.visible.should_not include hidden_bite
      
      visible_bite = Factory(:bite, :hidden => false)
      Bite.visible.should include visible_bite
    end
  end
  
  context "create_photo_by_image_url" do
    it "should create photo if the given image_url is valid" do
      bite = Factory(:bite, :image_url => "http://invalid.url")
      bite.photos.count.should == 0
    end
    
    it "should not create photo if the given image_url is invalid" do
      bite = Factory(:bite, :image_url => "https://encrypted.google.com/images/logos/ssl_logo_lg.gif")
      bite.photos.count.should == 1
    end
  end
  
  context "normalized_image_url" do
    it "should return original image url if image_url is a full valid url" do
      bite = Factory(:bite, :image_url => 'http://detourlab.com/images/original.png')
      bite.normalized_image_url.should == 'http://detourlab.com/images/original.png'
    end
    
    it "should return absolute image url if image_url is sub path" do
      bite = Factory(:bite, :url => 'http://detourlab.com', :image_url => '/images/pic.png')
      bite.normalized_image_url.should == 'http://detourlab.com/images/pic.png'
    end
    
    it "should return absolute image url if image_url is relative path" do
      bite = Factory(:bite, :url => 'http://detourlab.com/posts', :image_url => 'images/pic.png')
      bite.normalized_image_url.should == 'http://detourlab.com/posts/images/pic.png'
    end
    
    it "should return correct image url if image_url starts with //" do
      bite = Factory(:bite, :url => 'http://detourlab.com', :image_url => '//cdn.url/images/pic.png')
      bite.normalized_image_url.should == 'http://cdn.url/images/pic.png'
    end
  end
end