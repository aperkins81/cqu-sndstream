class SoundpostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: [:destroy]
  
  def create
    @soundpost = current_user.soundposts.build(params[:soundpost])
    sound = params[:soundpost][:content]
    @soundpost.content = sound.read
    @soundpost.filetype = sound.content_type
    @soundpost.ext = File.extname(sound.original_filename)
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
  
  def show
    #@soundpost = current_user.soundposts.find_by_id(params[:id])
    @soundpost = Soundpost.find(params[:id])
    send_data @soundpost.content, 
        :filename => "snd-#{@soundpost.id}#{@soundpost.ext}",
        :type => @soundpost.filetype, :disposition => 'inline'
  end
  
  
  private
  
    def correct_user
      @soundpost = current_user.soundposts.find_by_id(params[:id])
      redirect_to root_path if @soundpost.nil?
    end
end
