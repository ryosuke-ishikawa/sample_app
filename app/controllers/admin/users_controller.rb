class Admin::UsersController < Admin::AdminApplicationController
  def index
     @users = User.paginate(page: params[:page])
     if params[:name].present?
      @users = @users.get_by_name params[:name]
     end
     if params[:content].present?
      @users = @users.get_by_content params[:content]
     end
  end

  def  edit
    @user = User.find(params[:id])
  end

  def update
   @user = User.find(params[:id])
   if @user.update_attributes(user_params)
    redirect_to admin_users_url
   else
    render 'edit'
   end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User destroyed"
    redirect_to admin_users_url
  end


  
  private
    
    def user_params
       params.require(:user).permit(:name, :email, :password, :password_confirmatiion)
    end
    
  
end
