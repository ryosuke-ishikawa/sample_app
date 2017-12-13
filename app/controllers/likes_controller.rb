class LikesController < ApplicationController
    def create
      like = current_user.likes.new(micropost_id: params[:micropost_id])
      like.save
      respond_to do |format|
        format.js {
          @micropost = like.micropost
          render 'toggle.js'
        }
      end
    end

    def destroy
#     @like = Like.find_by(micropost_id: params[:micropost_id], user_id: params[:user_id])
      @micropost = Micropost.find(params[:id])
      like = current_user.likes.find_by(micropost_id: @micropost.id)
      
      like.destroy if like
     
      respond_to do |format|
        format.js { render 'toggle.js' }
      end
    end

    
    
    
    private
     def like_params
         params.require(:like).permit(:micropost_id)
     end
        
    
end

