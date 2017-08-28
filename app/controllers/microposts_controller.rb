class MicropostsController < ApplicationController
  before_action :authenticate_user!, :except=>[:edit,:update]
  before_action :correct_user,   only: :destroy
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_item = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end
  
  def edit
    @micropost = Micropost.find(params[:id])
  end
  
  def update
    @micropost = Micropost.find(params[:id])
    if @micropost.update_attributes(micropost_params)
      redirect_to admin_users_micropost_url
    else
      render 'edit'
    end
  end
  
  
  private

    def micropost_params
     if admin_user_signed_in?
      params.require(:micropost).permit(:content,:public)
     else
      params.require(:micropost).permit(:content)
     end
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end