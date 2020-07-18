class TutorialsController < ApplicationController
  before_action :teacher?, except: [:show]
  before_action :find_tutorial, except: [:index, :new, :create]
  before_action :author?, only: [:edit, :update, :destroy]

  def index
    @tutorials = current_user.tutorials
  end

  def new
    @tutorial = Tutorial.new
  end

  def create
    @tutorial = Tutorial.new(tutorial_params)
    @tutorial.user = current_user
    if @tutorial.save
      redirect_to tutorials_path
    else
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    if @tutorial.update(tutorial_params)
      redirect_to tutorials_path
    else
      render :edit
    end
  end

  def destroy
    if @tutorial.destroy
      notice = "刪除成功"
    else
      notice = "刪除失敗"
    end
    redirect_to tutorials_path, notice: notice
  end

  private
  def teacher?
    unless current_user.teacher?
      redirect_to root_path, notice: "無權限"
    end
  end

  def author?
    unless @tutorial.user == current_user
      redirect_to root_path, notice: "無權限"
    end
  end

  def find_tutorial
    @tutorial = Tutorial.find_by(id: params[:id])
  end

  def tutorial_params
    params.require(:tutorial).permit(
      :title,
      :price,
      :currency,
      :category_id,
      :available,
      :url,
      :desc,
      :expiration
    )
  end

end
