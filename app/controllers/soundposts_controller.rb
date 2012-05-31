class SoundpostsController < ApplicationController
  before_filter :signed_in_user
  
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
  end
end
