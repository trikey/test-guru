class QuestionsController < ApplicationController
  before_action :find_test, only: %i[index create new]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    render plain: Test.all.pluck(:title).join("\n")
  end

  def show
    render plain: Question.find(params[:id]).body
  end

  def create
    question = Question.create(question_params)
    redirect_to question_path(question)
  end

  def new
    @tests = Test.all
  end

  def destroy
    Question.destroy(params[:id])
    head 204
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def rescue_with_question_not_found
    render plain: 'Record was not found'
  end

  def question_params
    params.require(:question).permit(:body, :test_id)
  end
end
