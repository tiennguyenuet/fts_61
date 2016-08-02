class Admin::UsersController < ApplicationController
  before_action :check_admin
  before_action :check_supper, only: :update
  load_and_authorize_resource

  def index
    @search = User.search params[:q]
    @users = @search.result.order(created_at: :desc)
      .page(params[:page]).per Settings.per_page
  end

  def show
  end

  def update
    respond_to do |format|
      if @user.update user_params
        format.html do
          flash[:success] = t "controllers.admin.users_controller.update_success"
          redirect_to admin_users_path
        end
        format.json{render @user, status: :ok}
      else
        format.html do
          flash[:danger] = t "controllers.admin.users_controller.update_fail"
          redirect_to admin_users_path
        end
        format.json{render @user.error, status: :unprocessable_entity}
      end
    end
  end

  private
  def user_params
    params.require(:user).permit :id, :role
  end
end
