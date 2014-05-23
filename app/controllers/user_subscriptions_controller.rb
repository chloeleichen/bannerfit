class UserSubscriptionsController < ApplicationController

	before_filter :authenticate_user!, only: [:new]


	def new 

		 

		if params[:subscribe_id]
			@subscribe = User.find(params[:subscribe_id])
			@user_subscription = UserSubscription.new 
		else 

	
			flash[:error] = "subscribe required"
		
		end 


	end 



	 private
    # Use callbacks to share common setup or constraints between actions.
    # def set_user_subscription
    #   @user_subscription = user_subscriptions.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_subscription_params
      params.require(:user_subscription).permit(:user_id, :subscribe_id)
    end

end
