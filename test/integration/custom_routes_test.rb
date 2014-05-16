require 'test_helper'

class CustomRoutesTest < ActionDispatch::IntegrationTest
test "/login route opens login" do 

get'/login' 
assert_response :success 
end 

test "/register route opens resgiter" do 

get'/register' 
assert_response :success 
end


test "/logout route opens logout" do 

get'/logout' 
assert_response :redirect 
assert_redirected_to :root
end


end
