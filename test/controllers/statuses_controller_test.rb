require 'test_helper'

class StatusesControllerTest < ActionController::TestCase
  setup do
    @status = statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statuses)
  end

  test "should ask user login before new" do
    get :new
    assert_response :redirect 
    assert_redirected_to new_user_session_path 
  end


  test "should be logged in to post status" do 
    post :create, status: {content: "hello", name: "message"}
    assert_response :redirect
    assert_redirected_to new_user_session_path 


  end 


   test "should be logged in to edit" do 
    get :edit
    assert_response :redirect
    assert_redirected_to new_user_session_path 


  end 


   test "should be logged in to update" do 
    get :update
    assert_response :redirect
    assert_redirected_to new_user_session_path 


  end 


   test "should be logged in to delete" do 
    get :destroy
    assert_response :redirect
    assert_redirected_to new_user_session_path 


  end 

  # test "should create status when logged in " do

  #   assert_difference('Status.count') do
  #     post :create, status: { content: @status.content, name: @status.name }
  #   end

  #   assert_redirected_to status_path(assigns(:status))
  # end

  test "should show status" do
    get :show, id: @status
    assert_response :success
  end

  # test "should get edit" do
  #   get :edit, id: @status
  #   assert_response :success
  # end

  # test "should update status" do
  #   patch :update, id: @status, status: { content: @status.content, name: @status.name }
  #   assert_redirected_to status_path(assigns(:status))
  # end

  # test "should destroy status" do
  #   assert_difference('Status.count', -1) do
  #     delete :destroy, id: @status
  #   end

    # assert_redirected_to statuses_path
  # end
end
