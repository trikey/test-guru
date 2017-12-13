class TestsController < ApplicationController
  before_action :find_test, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
    @tests = Test.all
  end

  def show; end

  def edit; end

  def update
    if @test.update(test_params)
      redirect_to @test
    else
      render :edit
    end
  end

  def create
    @test = Test.new(test_params)
    if @test.save
      redirect_to @test
    else
      render :new
    end
  end

  def new
    @test = Test.new
  end

  def destroy
    Test.destroy(params[:id])
    redirect_to tests_path
  end

  private

  def find_test
    @test = Test.find(params[:id])
    @category = @test.category
    @questions = @test.questions
  end

  def rescue_with_test_not_found
    render plain: 'Record was not found'
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :author_id)
  end
end
