class SoundpostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy, :show]
  before_filter :correct_user, only: [:destroy]
  
  def create
    @soundpost = current_user.soundposts.build(params[:soundpost])
    sound = @soundpost.content
    # verify conent_type (e.g., 'audio/mpeg') starts with 'audio/'...
    valid = sound.content_type.starts_with? 'audio/'
    @soundpost.filetype = sound.content_type
    @soundpost.content = sound.read
    @soundpost.ext = File.extname(sound.original_filename)
    if valid and @soundpost.save
      flash[:success] = "SndStream created!"
      redirect_to root_path
    else
      @feed_items = []
      flash[:error] = "File must be an audio file! You uploaded a 
          #{sound.content_type} file." if !valid
      render 'static_pages/home'
    end
  end
  
  def destroy
    @soundpost.destroy
    redirect_to root_path
  end
  
  def show
    @soundpost = Soundpost.find(params[:id])
    send_data @soundpost.content, 
        :filename => "sndstream-#{@soundpost.id}#{@soundpost.ext}",
        :type => @soundpost.filetype, :disposition => 'inline'
  end
  
  
  private
  
    def correct_user
      @soundpost = current_user.soundposts.find_by_id(params[:id])
      redirect_to root_path if @soundpost.nil?
    end
end
