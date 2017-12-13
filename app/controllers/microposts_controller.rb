class MicropostsController < ApplicationController
  before_action :authenticate_user!, :except=>[:edit,:update, :destroy, :public_on, :public_off ]
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
    if admin_user_signed_in?
      redirect_to admin_users_micropost_url
    else
      redirect_to root_url
    end
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
  
  
  
  
#micropostのpublicを公開非公開にする
  def public_on
    @micropost = Micropost.find(params[:id])
    @micropost.update(public: true)
  end

  def public_off
    @micropost = Micropost.find(params[:id])
    @micropost.update(public: false)
  end
  
  
  
  private

    def micropost_params
     if admin_user_signed_in?
      params.require(:micropost).permit(:content, :picture, :public)
     else
      params.require(:micropost).permit(:content, :picture,)
     end
    end
    
    def correct_user
      if admin_user_signed_in?
        @micropost = Micropost.find_by(id: params[:id])
      else
        @micropost = current_user.microposts.find_by(id: params[:id])
        redirect_to root_url if @micropost.nil?
      end
    end
    
end