class QuestionsController < ApplicationController
  before_action :find_tests, only: %i[index create new]
  before_action :find_question, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @questions = @test.questions
    render 'tests/show'
  end

  def show; end

  def edit; end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def new
    @question = Question.new
  end

  def destroy
    Question.destroy(params[:id])
    redirect_to test_questions_path(@test)
  end

  private

  def find_tests
    @test = Test.find(params[:test_id])
    @tests = Test.all
  end

  def find_question
    @question = Question.find(params[:id])
    @test = @question.test
  end

  def rescue_with_question_not_found
    render plain: 'Record was not found'
  end

  def question_params
    params.require(:question).permit(:body, :test_id)
  end
end
