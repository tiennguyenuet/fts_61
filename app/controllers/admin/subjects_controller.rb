class Admin::SubjectsController < ApplicationController
  before_action :check_admin
  load_and_authorize_resource
  before_action :check_delete_subject, only: :destroy
  def index
    @search = Subject.search params[:q]
    @subjects = @search.result.order(created_at: :desc)
      .page(params[:page]).per Settings.per_page
    @subject = Subject.new
  end

  def new
  end

  def create
    @subject.save
    respond_to do |format|
        format.js
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

  def check_delete_subject
    if @subject.examinations.any?
      flash[:danger] = t "controllers.admin.subjects_controller.cant_delete"
      redirect_to admin_subjects_path
    end
  end
end
