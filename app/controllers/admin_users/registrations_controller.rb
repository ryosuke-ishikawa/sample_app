class AdminUsers::RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    admin_user_path(resource)
  end

  private

    def sign_up_params
      params.require(:admin_user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def account_update_params
      params.require(:admin_user).permit(:name, :email, :password, :password_confirmation, :current_password)
    end
end