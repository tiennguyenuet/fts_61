class ExaminationsController < ApplicationController
  load_and_authorize_resource

  def index
    @examinations = Examination.order(created_at: :desc)
      .page(params[:page]).per Settings.per_page
  end

  def new
  end

  def create
    @subject = Subject.find examination_params[:subject_id]
    @examination = current_user.examinations.build subject: @subject, status: :start
    if @examination.save
      flash[:success] =  t "controllers.exams_controller.create_success"
      redirect_to examinations_path
    else
      flash[:danger] = t "controllers.exams_controller.create_error"
      redirect_to :back
    end
  end

  private
  def examination_params
    params.require(:examination).permit :id, :user_id, :subject_id, :status,
      results_attributes: [:id, :examination_id, :question_id, :is_correct]
  end
end
