class AdminUsersController < ApplicationController
  def show
    @admin_user = admin_user.find(params[:id])
  end
end
