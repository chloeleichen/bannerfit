class UserSubscriptionsController < ApplicationController

	before_filter :authenticate_user!, only: [:new]


	def new 

		 

		if params[:subscribe_id]
			@subscribe = User.where(profile_name: params[:subscribe_id]).first



			raise ActiveRecord::RecordNotFound if @subscribe.nil?

			@user_subscription = current_user.user_subscriptions.new(subscribe: @subscribe) 
		else 

	
			flash[:error] = "subscribe required"
		
		end 

	

	rescue ActiveRecord::RecordNotFound 

		render file: "public/404", status: :not_found 
	 

	end 


	def create 

	@user_subscription = current_user.user_subscriptions.new(user_subscription_params) 
		if params[:user_subscription].has_key? (:subscribe_id)
			@subscribe = User.where(profile_name:params[:user_subscription][:subscribe_id]).first
			 

			
			@user_subscription.save 
			flash[:success] = "you have subscribed #{@subscribe.profile_name}"
		else 
			flash[:error] = "Firend required"
			redirect_to root_path 
		end 

	end 



	 private
    # Use callbacks to share common setup or constraints between actions.
    # def set_user_subscription
    #   @user_subscription = user_subscriptions.find(params[:id])
    # end

    #Never trust parameters from the scary internet, only allow the white list through.
    def user_subscription_params
      params.require(:user_subscription).permit(:user_id, :subscribe_id)
    end

end
