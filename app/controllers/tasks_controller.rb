class TasksController < ApplicationController
  
  before_action :require_user_logged_in
  before_action :set_task, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:destroy]
  
  def index
    @tasks = current_user.tasks.order(id: :desc).page(params[:page])
  end
  
  def new
    @task = current_user.tasks.build
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = '正常に投稿されました'
      redirect_to root_url
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    
    if @task.update(task_params)
      flash[:success] = 'タスクは更新されました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'タスクの更新に失敗しました'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = 'タスクは削除されました'
    redirect_to root_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def set_task
    @task = current_user.tasks.find_by(id: params[:id])
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end