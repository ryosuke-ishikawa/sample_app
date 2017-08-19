class AdminUsersController < ApplicationController
  before_action :authenticate_admin_user!, :except=>[:show]
  def show
    @admin_user = AdminUser.find(params[:id])
  end
  
  def destroy
    AdminUser.find(params[:id]).destroy
    flash[:success] = "Admin_User destroyed"
    redirect_to admin_users_url
  end
  
  
  
end
