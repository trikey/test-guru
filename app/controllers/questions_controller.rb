class QuestionsController < ApplicationController
  before_action :find_tests, only: %i[create new]
  before_action :find_question, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def show; end

  def edit; end

  def update
    if @question.update(question_params)
      redirect_to @question.test
    else
      render :edit
    end
  end

  def create
    @question = @test.questions.new(question_params)
    if @question.save
      redirect_to @question.test
    else
      render :new
    end
  end

  def new
    @question = @test.questions.new
  end

  def destroy
    @question.destroy
    redirect_to @question.test
  end

  private

  def find_tests
    @test = Test.find(params[:test_id])
    @tests = Test.all
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def rescue_with_question_not_found
    render plain: 'Record was not found'
  end

  def question_params
    params.require(:question).permit(:body)
  end
end
