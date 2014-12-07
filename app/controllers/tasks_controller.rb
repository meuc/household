require "grouper"

class TasksController < ApplicationController
  def index
    all_tasks = Task.all.order_by(:created_at)
    @tasks = Grouper.new(all_tasks).group_by(:interval_name, :size_name)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params.fetch(:id))
  end

  def update
    @task = Task.find(params.fetch(:id))

    respond_to do |format|
      format.html do
        if @task.update(task_params)
          redirect_to root_path
        else
          render :edit
        end
      end

      format.json do
        @task.done = if params[:task] && params[:task][:done]
                       Date.parse(params[:task][:done])
                     else
                       nil
                     end

        if @task.save
          render json: @task, status: :ok
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end
    end
  end

  private

  def task_params
    params.require(:task).permit(:text, :user_id, :size_id, :interval_id)
  end
end
