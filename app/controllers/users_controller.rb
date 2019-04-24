class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def initialize
    super
    @resource = "Users"
  end

  # CREATE
  def create
    @user = User.new(user_params)
    session[:return_to] ||= request.referer
    if @user.save
      log_in @user
      flash[:success] = "Created user"
      redirect_to @user
    else
      render :new
    end
  end

  def new
    @user = User.new if @user == nil
  end

  # READ
  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
  end

  def index 
    @users = User.paginate(page: params[:page], :per_page => 15)
  end

  # UPDATE
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
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Deleted user"
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end