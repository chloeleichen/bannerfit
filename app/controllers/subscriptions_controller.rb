class SubscriptionsController < ApplicationController

	before_filter :authenticate_user!, only: [:new]





def create 
  @subscribed = User.find(params[:subscription][:subscribed_id])
  
  current_user.subscriptions.create!(subscribed_id: @subscribed.id )
  flash[:success] = "You have subscribed to #{@subscribed.profile_name}"
  redirect_to profile_path(@subscribed.profile_name)


   
end 


def destroy 

    @subscribed = Subscription.find(params[:id]).subscribed
    current_user.subscriptions.find_by(subscribed_id: @subscribed.id).destroy 
    flash[:success] = "You have unsubscribed #{@subscribed.profile_name}"
    redirect_to profile_path(@subscribed.profile_name)




end 


 # def create
 #    if subscription_params && subscription_params.has_key?(:subscribed_id)
 #      @subscribed = User.where(profile_name:params[:subscription][:subscribed_id]).first
 #      @subscription = current_user.subscriptions.new(subscribed:@subscribed)
 #      @subscription.save 
 #      flash[:success] = "saved"
 #    else 
 #      flash[:error] = "Firend required"
 #      redirect_to root_path 
 #    end 
    
 #  end

 #  def destroy
 #    @user = Subscription.find(params[:id]).subscribed
 #    current_user.unsubscribe!(@user)
 #    respond_to do |format|
 #      format.html { redirect_to @user }
 #      format.js
 #    end
 #  end

 

	 private


    # Use callbacks to share common setup or constraints between actions.
    # def set_subscription
    #   @subscription = subscriptions.find(params[:id])
    # end
  


    #Never trust parameters from the scary internet, only allow the white list through.
    def subscription_params
      params.require(:subscription).permit(:subscribed_id)
    end

end
