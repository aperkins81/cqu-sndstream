class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "G'day there #{@user.name}, welcome to SndStream!"
      redirect_to @user
    else
      flash[:error] = "Could not create user, try again."
      render 'new'
    end
    rescue ActiveRecord::StatementInvalid
    # Handle duplicate email addresses gracefully by redirecting.
    # TODO: Test flash message appears in this rare circumstance.
    flash = { error: "Sorry, someone beat you to that email address - try another!" }
    redirect_to signup
  end
end
