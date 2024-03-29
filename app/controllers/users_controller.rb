class UsersController < ApplicationController
  before_filter :signed_in_user, 
    only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def index
    @users = User.paginate(page: params[:page])
    # TODO: Find better way of doing this:
    @headings = ["", "Name", "Join Date" ]
    admin_headings = [ "Delete?" ]
    if current_user.admin?
      admin_headings.each do |ah|
        @headings.push ah
      end
    end
#    respond_to do |format|
#      format.html
#      format.mobile
#    end
  end
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @soundposts = @user.soundposts.paginate(page: params[:page])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "G'day there #{@user.name} and welcome to SndStream!"
      redirect_to @user
    else
      flash[:error] = "Could not create user, please try again."
      render 'new'
    end
    rescue ActiveRecord::StatementInvalid
    # Handle duplicate email addresses gracefully by redirecting.
    flash[:error] = "Sorry, that email address is already in use - try another!"
    redirect_to signup
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile successfully updated."
      sign_in @user
      redirect_to @user
    else
      flash[:error] = "Could not update your profile, please try again."
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_path
  end
  
  private
  
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
