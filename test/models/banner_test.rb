require 'test_helper'

class BannerTest < ActiveSupport::TestCase
   test "should require name and content " do

   	banner= Banner.new 

   	# banner.name = "test"
   	# banner.content="test content"
   	# banner.user_id = "1"

   	assert !banner.save 
   	assert !banner.errors[:name].empty?
   	assert !banner.errors[:content].empty?
   	assert !banner.errors[:user_id].empty?

     
   end


end
