class BannersController < ApplicationController
  before_action :set_banner, only: [:show, :edit, :update, :destroy]

  # AUTHENTICATE USER WITH DEVISE 


  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :feed]

  
  # GET /banners
  # GET /banners.json
  def index
    @banners = Banner.all
  end

  # GET /banners/1
  # GET /banners/1.json
  def show
  end

  # GET /banners/new
  def new
    @banner = current_user.banners.new
  end

  # GET /banners/1/edit
  def edit
  end

  # POST /banners
  # POST /banners.json
  def create
    @banner = current_user.banners.new(banner_params)

    respond_to do |format|
      if @banner.save
        format.html { redirect_to @banner, notice: 'banner was successfully created.' }
        format.json { render :show, banner: :created, location: @banner }
      else
        format.html { render :new }
        format.json { render json: @banner.errors, banner: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /banners/1
  # PATCH/PUT /banners/1.json
  def update
    respond_to do |format|

      if @banner.update(banner_params) && current_user.id == @banner.user_id 
        format.html { redirect_to @banner, notice: 'banner was successfully updated.' }
        format.json { render :show, banner: :ok, location: @banner }
      else
        # format.html { render :index }
        # format.json { render json: @banner.errors, banner: :unprocessable_entity }
        flash[:alert] = "Access denied"
        redirect_to banners_path 
        return false
      end
    end 
  end

  # DELETE /banners/1
  # DELETE /banners/1.json
  def destroy

    if current_user.id == @banner.user_id 

    @banner.destroy
    respond_to do |format|
    format.html { redirect_to banners_url, notice: 'banner was successfully destroyed.' }
    format.json { head :no_content }
    end

    else 
      flash[:alert] = "Access denied"
      redirect_to banners_path 
      return false
    end 

    
  end


  def feed
    @banners = Banner.from_users_subscribed_by(current_user)
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_banner
      @banner = Banner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def banner_params
      params.require(:banner).permit(:name, :content, :user_id, :pic)
    end
end
