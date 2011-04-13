require 'spec_helper'

describe Bite do
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
end