class TaskEntriesController < ApplicationController
    before_action :logged_in_user

    def initialize 
        super
        @resource = "Task Entries"
      end

    # CREATE
    def create 
        @task_entry = TaskEntry.new(task_entry_params)
        if @task_entry.save
        flash[:success] = "Created task entry"
        redirect_to @task_entry
        else
        render :new
        end 
    end

    def new
        @task_entry = TaskEntry.new if @task_entry == nil
        @task_options = Task.all.map{|t|[t.task_name, t.id]}
    end

    # READ
    def index 
        @task_entries = TaskEntry.joins(:task).where("tasks.user_id = ?", current_user.id).paginate(page: params[:page], :per_page => 10)
        
        @total_duration = @task_entries.map do |task_entry|
            task_entry.duration.present? ? task_entry.duration : 0
        end.sum
    end

    def show 
        @task_entry = TaskEntry.find(params[:id])
    end

    # UPDATE
    def update
        @task_entry = TaskEntry.find(params[:id])
        if @task_entry.update_attributes(task_entry_params)
            flash[:success] = "Updated task entry"
            redirect_to @task_entry
        else
            render 'edit'
        end
    end

    def edit 
        @task_entry = TaskEntry.find(params[:id])
    end 
    
    # DESTROY
    def destroy
        TaskEntry.find(params[:id]).destroy
        flash[:success] = "Deleted task entry"
        redirect_to task_entries_url
    end

    def start_now
      @task_entry = TaskEntry.find(params[:task_entry_id])
      @task_entry.start_time = Time.now
      @task_entry.save
      flash[:success] = "Started timer"
      redirect_to task_entries_url
    end

    def stop_now
      @task_entry = TaskEntry.find(params[:task_entry_id])
      @task_entry.duration = (Time.now - @task_entry.start_time)/60
      @task_entry.save
      flash[:success] = "Stop timer"
      redirect_to task_entries_url
    end

    private 
    def task_entry_params 
      params.require(:task_entry).permit(:note, :start_time, :task_id, :duration)
    end
end