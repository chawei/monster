require 'spec_helper'

describe Photo do
  it { should have_and_belong_to_many :bites }
end