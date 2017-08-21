class AdminUsersController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :owner,     only: :destroy
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
 
 
  private 
 
  def owner
    redirect_to(root_path) unless current_admin_user.owner?
  end
 
end
