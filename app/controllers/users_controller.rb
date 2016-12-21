class UsersController < ApplicationController
  before_action :authenticate_user!
  
# The .includes combines all your database together instead
# of having separate tables for each user. This is the same
# as having @users = Users.all
  def index
    @users = User.includes(:profile)
    
  end
  
  # GET to /users/:id
  def show
    @user = User.find( params[:id] )
  end
end