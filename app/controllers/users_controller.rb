# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def show; end

  def edit; end

  def update
    notice = current_user.update(user_params) ? 'Successfuly Updated' : 'Something went wrong'
    redirect_to user_path, notice:
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :name)
  end
end
