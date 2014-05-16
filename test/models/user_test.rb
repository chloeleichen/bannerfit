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


  test"profile_name should not have space" do 

  	user= User.new(first_name: 'Chloe', last_name: 'Chen', email: 'chloe@test.com')
    user.password = user.password_confirmation ="12345678"

    # PAY ATTENTION TO PASSWORD LENGTH 

    user.profile_name = "name with space "

     
  	

  	assert !user.save
  	assert !user.errors[:profile_name].empty?

    puts user.errors.inspect 


    # PAY ATTENTION TO SYNTAX HERE, TREEHOUSE WRONG 


  	assert user.errors.any?{|k, v| v.include? "does not allow white space"}

    # Problems here

  end 


test"profile_name should pass " do 

    user= User.new(first_name: 'Chloe', last_name: 'Chen', email: 'chloe@test.com')
    user.password = user.password_confirmation ="12345678"

    user.profile_name = "name123"

  
    assert user.valid?

  

  end 


end
