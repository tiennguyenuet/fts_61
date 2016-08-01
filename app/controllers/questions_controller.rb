class QuestionsController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource only: [:index]
  before_action :load_all_subject

  def index
    @questions = Question.where(user_id: current_user.id).page(params[:page])
      .per Settings.per_page
  end

  def show
  end

  def new
    @question = Question.new
    @question.answers.new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @question.update question_params
        format.html do
          flash[:success] = t "views.admin.question.update_success"
          redirect_to questions_path
        end
        format.json{render @question, status: :ok}
      else
        format.html do
          flash[:danger] = t "views.admin.question.update_fail"
          render action: :edit
        end
        format.json{render @question.errors, status: :unprocessable_entity}
      end
    end
  end

  def create
    @question = current_user.questions.new question_params
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
      if @question[:question_type] == Settings.single
        if quantity == Settings.num_answer_single
          flag = true
        else
          @message = t "views.admin.question.single_question_error"
        end
      elsif @question[:question_type] == Settings.multiple
        if quantity > Settings.num_answer_single
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
        redirect_to questions_path
      else
        flash[:danger] = t "views.admin.question.create_fail"
        render action: :new
      end
    else
      flash[:danger] = @message
      render action: :new
    end
  end

  private
  def question_params
    params.require(:question).permit :id, :content, :question_type, :subject_id,
    :state, :user_id, answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def load_all_subject
    @subjects =  Subject.all
  end
end
