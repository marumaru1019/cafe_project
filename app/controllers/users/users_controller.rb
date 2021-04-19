class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @event_joins = EventJoin.all.where(user_id: @user.id)
  end
  def edit
    @user = User.find(params[:id])
    @events = @user.event_joins
  end
  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user)
  end
  def welcome
    @user = User.first
    @unchi = "うんち"
  end
  private
  def user_params
    params.require(:user).permit(:name, :user_image, :grade, :university)
  end
end

