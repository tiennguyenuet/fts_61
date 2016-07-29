class Admin::QuestionsController < ApplicationController
  before_action :check_admin
  load_and_authorize_resource
  before_action :load_all_subject, except: :destroy
  before_action :check_exist_exam, only: :destroy
  def index
    @search = Question.search params[:q]
    @questions = @search.result.order(created_at: :desc)
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
      @message = t "views.admin.question.no_answer"
      render action: :new
      return
    else
      @answers.each do |answer|
        if answer[1][:is_correct].to_i == 1
          quantity += 1
        end
      end
      if @question[:question_type] == 0
        if quantity == 1
          flag = true
        else
          @message = t "views.admin.question.single_question_error"
        end
      elsif @question[:question_type] == 1
        if quantity == 2
          flag = true
        else
          @message = t "views.admin.question.multiple_question_error"
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
        render action: :new
      end
    else
      flash[:danger] = @message
      render action: :new
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
    respond_to do |format|
      if @question.results.size > 0
        @message = t "views.admin.question.cant_delete"
      else
        @question.destroy
        format.html do
          flash[:success] = t "views.admin.question.deleted"
          redirect_to admin_questions_path
        end
        format.json{head :nocontent}
      end
    end
  end

  def edit
  end

  private
  def check_exist_exam
    if @question.results.any?
      flash[:danger] = "views.admin.question.cant_delete"
      redirect_to admin_questions_path
    end
  end

  def load_all_subject
    @subjects = Subject.all
  end

  def question_params
    params.require(:question).permit :id, :subject_id, :content, :question_type,
      :state, answers_attributes: [:id, :content, :is_correct, :_destroy]
  end
end
