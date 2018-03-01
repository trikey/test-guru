class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show result update gist]
  before_action :check_passage_time, only: %i[show update]

  def show; end

  def result; end

  def update
    @test_passage.accept!(params[:answer_id])

    if @test_passage.completed?
      @test_passage.add_badges
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    result = GistQuestionService.new(@test_passage.current_question).call

    @gist = current_user.gists.new(
      unique_hash: result['id'],
      question: @test_passage.current_question
    )

    flash_options = if @gist.save
                      { notice: "#{t('.success')} #{result['html_url']}" }
                    else
                      { notice: t('.failure') }
                    end

    redirect_to @test_passage, flash_options
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def check_passage_time
    redirect_to tests_path, alert: 'time is out!' if @test_passage.time_left <= 0
  end
end
