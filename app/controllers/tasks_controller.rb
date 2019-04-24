class TasksController < ApplicationController
  before_action :logged_in_user

  def initialize 
      super
      @resource = "Tasks"
      end

  # CREATE
  def create 
      @task = Task.new(task_params)
      if @task.save
      flash[:success] = "Created task"
      redirect_to @task
      else
      render :new
      end 
  end

  def new
      @task = Task.new if @task == nil
      @project_options = Project.all.map{|p|[p.project_name, p.id]}
      @user_options = User.all.map{|u|[u.username, u.id]}
  end

  # READ
  def index 
      @tasks = Task.paginate(page: params[:page], :per_page => 10)
  end

  def show 
      @task = Task.find(params[:id])
      @task_entries = @task.task_entries
      @project = @task.project_id
      @user = @task.user_id
  end

  # UPDATE
  def update
      @task = Task.find(params[:id])
      if @task.update_attributes(task_params)
      flash[:success] = "Updated task"
      redirect_to @task
      else
      render 'edit'
      end
  end

  def edit 
      @task = Task.find(params[:id])
  end 

  # DESTROY
  def destroy
      Task.find(params[:id]).destroy
      flash[:success] = "Deleted task"
      redirect_to tasks_url
  end

  private 
  def task_params 
      params.require(:task).permit(:project_id, :user_id, :task_name)
  end
end