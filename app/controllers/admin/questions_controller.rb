class Admin::QuestionsController < ApplicationController
  load_and_authorize_resource
  before_action :load_all_subject, except: :destroy

  def index
    @questions = Question.includes(:subject)
      .page(params[:page]).per Settings.per_page
    respond_to do |format|
      format.html
      format.json{render json: @questions}
    end
  end

  def new
    @question = Question.new
    @question.answers.new
  end

  def create
    @question = Question.new question_params
    @answers = question_params[:answers_attributes]
    quantity = 0
    flag = false
    if @answers.nil?
      flash[:danger] = t "views.admin.question.no_answer"
      render action: :new
    else
      @answers.each do |answer|
        if answer[1][:is_correct].to_i == 1
          quantity += 1
        end
      end
      if @question[:question_type] == 0
        if quantity == 1
          flag = true
        end
      elsif @question[:question_type] == 1
        if quantity == 2
          flag = true
        end
      else
        flag = true
      end
    end
    if flag
      if @question.save
        flash[:success] = t "views.admin.question.create_success"
        redirect_to admin_questions_path
      else
        flash[:danger] = t "views.admin.question.create_fail"
        redirect_to :back
      end
    else
      flash[:danger] = t "views.admin.question.create_fail"
      redirect_to :back
    end
  end

  def update
    respond_to do |format|
      if @question.update question_params
        format.html do
          flash[:success] = t "views.admin.question.update_success"
          redirect_to admin_questions_path
        end
        format.json{render @question, status: :ok}
      else
        format.html do
          flash[:danger] = t "views.admin.question.update_fail"
          render action: :edit
        end
        format.json{render @question.error, status: :unprocessable_entity}
      end
    end
  end

  def destroy
  end

  def edit
  end

  private

  def load_all_subject
    @subjects = Subject.all
  end

  def question_params
    params.require(:question).permit :id, :subject_id, :content, :question_type,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end
end
