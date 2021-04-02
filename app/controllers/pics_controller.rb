# frozen_string_literal: true

class PicsController < ApplicationController
  before_action :find_pic, only: %i[show update edit destroy]
  before_action :correct_user, only: %i[update edit destroy]
  

  def index
    @pics = Pic.all.order('created_at DESC')
  end

  def show; end

  def new
    @pic = current_user.pics.build
  end

  def create
    @pic = current_user.pics.build(pic_params)

    if @pic.save
      redirect_to @pic, notice: 'Pic is saved/Posted !!!!!!!!!'
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @pic.update(pic_params)
      redirect_to @pic, notice: 'Congrats the pic was updated!'
    else
      render 'edit'
    end
  end

  # authentication correct user
  def correct_user
    @pic = current_user.pics.find_by(id: params[:id])
    redirect_to pics_path, notice: 'Not authorised to do this action!!' if @pic.nil?
  end

  def destroy
    @pic.destroy
    redirect_to root_path
  end

  private

  def pic_params
    params.require(:pic).permit(:title, :description, :image)
  end

  def find_pic
    @pic = Pic.find(params[:id])
  end
end
