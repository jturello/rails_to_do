class TasksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @task = @list.tasks.new
  end

  def create
    @list = List.find(params[:list_id])
    @task = @list.tasks.new(task_params)
    @task.done = false
    if @task.save
      redirect_to list_path(@task.list)
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
    @list = List.find(@task.list_id)
  end

  def update
    @task= Task.find(params[:id])
    if @task.update(task_params)
      redirect_to list_path(@task.list)
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to list_path(@task.list)
  end


  private
  def task_params
    params.require(:task).permit(:description, :due_date, :done)
  end
end
