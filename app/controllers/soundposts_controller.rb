class SoundpostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: [:destroy]
  
  def create
    @soundpost = current_user.soundposts.build(params[:soundpost])
    if @soundpost.save
      flash[:success] = "SndStream created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end
  
  def destroy
    @soundpost.destroy
    redirect_to root_path
  end
  
  
  private
  
    def correct_user
      @soundpost = current_user.soundposts.find_by_id(params[:id])
      redirect_to root_path if @soundpost.nil?
    end
end
