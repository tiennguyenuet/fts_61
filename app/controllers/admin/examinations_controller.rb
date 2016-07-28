class Admin::ExaminationsController < ApplicationController
  before_action :check_admin
  load_and_authorize_resource

  def index
    @examinations = Examination.order(created_at: :desc)
      .page(params[:page]).per Settings.per_page
  end

  def show
  end

  def update
    if params[:commit] == "checked" && @examination.checked!
      SendResultWorker.perform_async @examination.id
      flash.now[:success] = t "controllers.admin.exams_controller.check_success"
      redirect_to admin_examinations_path
    else
      flash.now[:danger] = t "controllers.admin.exams_controller.check_error"
      redirect_to :back
    end
  end
end
