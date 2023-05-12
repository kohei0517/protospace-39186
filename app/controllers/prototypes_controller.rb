class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :useronly , only: :edit
  def index
    @prototype = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.all
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype.id)
    else
      render :edit
    end
  end

  def destroy
    Prototype.delete(params[:id])
    redirect_to action: :index
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title,:concept,:catch_copy,:image).merge(user_id: current_user.id)
  end

  def useronly
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      redirect_to action: :index
    end 
  end
end
