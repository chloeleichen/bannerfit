require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # test "a user should have first name, last name and profile name  " do 
  # 	user = User.new 

  # 	assert !user.save 

  # 	assert !user.errors[:first_name].empty?
  # 	assert !user.errors[:profile_name].empty?
  # 	assert !user.errors[:last_name].empty?
  # end 


  # test "unique profilw_name for user" do 
  # 	user = User.new 

  # user.profile_name = users(:Chloe).profile_name
  # users(:Chloe)



  # 	assert !user.save 

  	

  # 	assert !user.errors[:profile_name].empty?
  # end 


  test"profile_name shoudlnt have space" do 

  	user= User.new 

  	users(:Chloe)
  	user.profile_name =users(:Chloe).profile_name

  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  	assert user.errors.include?("Profile name only allows letters")

    # Problems here

  end 





end
