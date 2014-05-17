class ProfilesController < ApplicationController
  def show

  	@user= User.find_by_profile_name(params[:id])

  	if @user 

  		@banners = @user.banners.all

  		render actions: :show 

  	else 

  	render file: 'public/404', banner: 404, formats: [:html] 
    end 

  end
end
