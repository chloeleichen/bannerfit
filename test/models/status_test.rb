require 'test_helper'

class StatusTest < ActiveSupport::TestCase
   test "should require name and content " do

   	status= Status.new 

   	# status.name = "test"
   	# status.content="test content"
   	# status.user_id = "1"

   	assert !status.save 
   	assert !status.errors[:name].empty?
   	assert !status.errors[:content].empty?
   	assert !status.errors[:user_id].empty?

     
   end


end
