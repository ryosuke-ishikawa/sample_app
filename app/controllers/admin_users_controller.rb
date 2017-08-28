class AdminUsersController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :owner,     only:[:destroy,:new,:create]

  def show
    @admin_user = AdminUser.find(params[:id])
  end
  
  def destroy
    AdminUser.find(params[:id]).destroy
    flash[:success] = "Admin_User destroyed"
    redirect_to admin_users_url
  end
  
  def index
   @admin_users = AdminUser.paginate(page: params[:page])
  end
  
  def  edit
    @admin_user = AdminUser.find(params[:id])
  end
  
  def update
    @admin_user = AdminUser.find(params[:id])
    if @admin_user.update_attributes(admin_user_params)
      flash[:success] = "Profile updated"
      redirect_to @admin_user
    else
      render 'edit'
    end
  end
  
  def new
    @admin_user = AdminUser.new
  end
  
  def create
    @admin_user = AdminUser.new(admin_user_params)
    if @admin_user.save
      flash[:success] = "Admin_user Created"
      redirect_to @admin_user
    else
      render 'new'
    end
  end
  
  def micropost
    if admin_user_signed_in?
      @microposts = Micropost.paginate(page: params[:page])
    end
  end
  
  def feed
    Micropost.all
  end
  


  private

  def owner
    redirect_to(root_path) unless current_admin_user.owner?
  end
  
  def admin_user_params
    if current_admin_user.owner?
     params.require(:admin_user).permit(:name, :email, :password, :password_confirmatiion, :owner)
    else
     params.require(:admin_user).permit(:name, :email, :password, :password_confirmatiion)
    end
  end
  
end