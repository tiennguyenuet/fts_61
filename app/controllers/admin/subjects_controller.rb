class Admin::SubjectsController < ApplicationController
  load_and_authorize_resource

  def index
    @subjects = Subject.order(created_at: :desc)
      .page(params[:page]).per Settings.per_page
  end

  def new
  end

  def create
    if @subject.save
      flash[:success] = t "controlllers.admin.subject_controller.create_success"
      redirect_to admin_subjects_path
    else
      flash[:danger] =  t "controlllers.admin.subject_controller.create_error"
      render :new
    end
  end

  private
  def subject_params
    params.require(:subject).permit :name, :total_question,
      :duration, :description
  end
end
