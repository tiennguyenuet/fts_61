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
      flash[:success] = t "controllers.admin.subjects_controller.create_success"
      redirect_to admin_subjects_path
    else
      flash[:danger] =  t "controllers.admin.subjects_controller.create_error"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = t "controllers.admin.subjects_controller.update_success"
      redirect_to admin_subjects_path
    else
      flash[:danger] = t "controllers.admin.subjects_controller.update_error"
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      flash[:success] = t "controllers.admin.subjects_controller.delete_success"
      redirect_to admin_subjects_path
    else
      flash[:danger] = t "controllers.admin.subjects_controller.delete_error"
      redirect_to :back
    end
  end

  private
  def subject_params
    params.require(:subject).permit :name, :total_question,
      :duration, :description
  end
end
