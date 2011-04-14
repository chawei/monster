require 'spec_helper'

describe Photo do
  setup do
    Photo.any_instance.stubs(:save_attached_files).returns(true)
    Photo.any_instance.stubs(:delete_attached_files).returns(true)
    Paperclip::Attachment.any_instance.stubs(:post_process).returns(true)
  end
  
  it { should have_and_belong_to_many :bites }
end