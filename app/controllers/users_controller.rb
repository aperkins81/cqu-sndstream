class UsersController < ApplicationController
  def new
  end
  
  def create
    
    rescue ActiveRecord::StatementInvalid
    # Handle duplicate email addresses gracefully by redirecting.
    redirect_to root_path
  end
end
