class Admin::MicropostsController < Admin::AdminApplicationController
  before_action :set_micropost, only: [:edit, :update, :destroy, :public_on, :public_off]
  def index
    @search_form = MicropostSearchForm.new(params[:search])
    @microposts = @search_form.search.paginate(page: params[:page])
  end

  def edit
  end

  def update
   if @micropost.update_attributes(micropost_params)
    redirect_to admin_microposts_url
   else
    render 'edit'
   end
  end

  def destroy
    @micropost.destroy
    redirect_to admin_microposts_url
  end

#micropostのpublicを公開非公開にする
  def public_on
    @micropost.update(public: true)
  end

  def public_off
    @micropost.update(public: false)
  end
  
  private

  def micropost_params
      params.require(:micropost).permit(:content, :picture, :public)
  end
  
  def set_micropost
    @micropost = Micropost.find(params[:id])
  end
end