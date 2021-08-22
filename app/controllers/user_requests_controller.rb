class UserRequestsController < ApplicationController
  before_action :move_to_signed_in

  def new
    @user_request = UserRequest.new
    @user_request_tags = UserRequestTag.all
  end
  def create
    @user_request_tags = UserRequestTag.all
    user_request = UserRequest.new(user_request_params)
    user_request.user_id = current_user.id
    if user_request.valid?
      user_request.save
      flash[:notice] = t('.success')
      redirect_to thanks_user_requests_path
    else
      flash[:alert] = t('.alert')
      redirect_to new_user_request_path
    end
  end

  private

  def user_request_params
    params
    .require(:user_request)
    .permit(:user_request_tag_id, :text, :confirm)
  end
end
