class UsersController < ApplicationController
before_filter :authenticate_user!


  def subscribed
    @title = "Subscribing"
    @user= User.find_by_profile_name(params[:id])
    @users = @user.subscribeds
    render 'show_subscribe'
  end

  def subscribers
    @title = "Subscribers"
    @user= User.find_by_profile_name(params[:id])
    @users = @user.subscribers
    render 'show_subscribe'
  end


end