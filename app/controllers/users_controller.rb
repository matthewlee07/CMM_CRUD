class UsersController < ApplicationController
  
  # CREATE
  def create 
    @user = User.new(user_params)
    
    if @user.save
    
      flash[:success] = "Created user"
      redirect_to @user
    else
      render :new
    end 
  end

  def new
    @user = User.new
  end

  # READ
  def show 
    @user = User.find(params[:id])
  end

  #  UPDATE

  # DESTROY

  private 
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
