class QuestionsController < ApplicationController
  before_action :find_tests, only: %i[index create new]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    render plain: @test.questions.pluck(:body).join("\n")
  end

  def show
    render plain: Question.find(params[:id]).body
  end

  def create
    question = @test.questions.create(question_params)
    redirect_to question_path(question)
  end

  def new; end

  def destroy
    Question.destroy(params[:id])
    render plaint: 'Question was deleted'
  end

  private

  def find_tests
    @test = Test.find(params[:test_id])
    @tests = Test.all
  end

  def rescue_with_question_not_found
    render plain: 'Record was not found'
  end

  def question_params
    params.require(:question).permit(:body)
  end
end
