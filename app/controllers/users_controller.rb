class UsersController < ApplicationController
  before_action :authenticate_user!

  def show; end

  def edit; end

  def update
    if current_user.update(user_params)
      redirect_to user_path, notice: "Successfuly Updated"
    else
      redirect_to user_path, alert: "Something went wrong"
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :name)
  end
end
