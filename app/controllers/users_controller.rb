class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  # CREATE
  def create 
    @user = User.new(user_params)
    # session[:return_to] ||= request.referer
    if @user.save
      log_in @user
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
  def edit 
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Updated user"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # DESTROY

  private 
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
end
