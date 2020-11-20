class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @q = current_user.task.ransack(params[:q])
    @tasks = @q.result(distinct: true).recent
  end

  def show
    @task = current_user.task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.task.new(task_params)

    if params[:back].present?
      render :new
      return
    end

    if @task.save
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました"
    else
      render :new
    end
  end

  def edit
    @task = current_user.task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update!(task_params)
    redirect_to task_url, notice: "タスク「#{task.name}」を更新しました"
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}」を削除しました"
  end

  def confirm_new
    @task = current_user.task.new(task_params)
    render :new unless @task.valid?
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def set_task
    @task = current_user.task.find(params[:id])
  end
end
