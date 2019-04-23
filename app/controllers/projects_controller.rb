class ProjectsController < ApplicationController
  before_action :logged_in_user

  def initialize
    super
    @resource = "Projects"
  end

  # CREATE
  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:success] = "Created project"
      redirect_to @project
    else
      render :new
    end
  end

  def new
    @customer_options = Customer.all.map{|c|[c.company, c.id]}
    @project = Project.new if @project == nil
  end

  # READ
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    @tasks = @project.tasks
  end

  # UPDATE
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:success] = "Updated project"
      redirect_to @project
    else
      render 'edit'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  # DESTROY
  def destroy
    Project.find(params[:id]).destroy
    flash[:success] = "Deleted project"
    redirect_to projects_url
  end

  private
  def project_params
    params.require(:project).permit(:project_name, :customer_id)
  end
end