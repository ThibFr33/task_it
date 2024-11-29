class TasksController < ApplicationController

  def create
    @list = List.find(params[:list_id])
    @task = Task.new(task_params)
    @task.list = @list
    if @task.save
      redirect_to list_path(@list)
    else
      render :show, status: :unprocessable_entity
    end
  end

  def update
    @task = Task.find(params[:id])
    @list = @task.list
    @task.update(task_params)
    redirect_to list_path(@list)
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:label, :done)
  end
end
