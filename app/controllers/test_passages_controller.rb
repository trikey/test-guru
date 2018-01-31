class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show result update gist]

  def show; end

  def result; end

  def update
    @test_passage.accept!(params[:answer_id])

    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    gist = GistQuestionService.new(@test_passage.current_question).call

    if gist['id']
      Gist.create(
        unique_hash: gist['id'],
        question: @test_passage.current_question,
        user: current_user
      )
    end

    flash_options = if gist['html_url']
                      { notice: "#{t('.success')} #{gist['html_url']}" }
                    else
                      { notice: t('.failure') }
                    end

    redirect_to @test_passage, flash_options
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
