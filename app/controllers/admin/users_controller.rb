class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @search = User.search params[:q]
    @users = @search.result.order(created_at: :desc)
      .page(params[:page]).per Settings.per_page
  end

  def show
  end

  def destroy
    if @user.destroy
      flash[:success] = t "controllers.admin.users_controller.delete_success"
      redirect_to admin_users_path
    else
      flash[:danger] = t "controllers.admin.users_controller.delete_error"
      redirect_to :back
    end
  end
end
