class AdminUsersController < ApplicationController
  def show
    @admin_user = AdminUser.find(params[:id])
  end
end
