class TutorialsController < ApplicationController
  before_action :teacher?
  before_action :find_tutorial, except: [:index, :new, :create]
  before_action :author?, except: [:index, :new, :create]

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
    result = params.require(:tutorial).permit(
      :title,
      :price,
      :price_type,
      :catagory,
      :available,
      :url,
      :desc,
      :expiration
    )
    result[:price_type] = result[:price_type].to_i
    result[:catagory]   = result[:catagory].to_i
    result[:expiration] = result[:expiration].to_i

    return result
  end

end
