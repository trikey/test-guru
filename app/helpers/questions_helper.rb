module QuestionsHelper
  def question_header(question, test)
    if question.id.nil?
      "Create New #{test.title} Question"
    else
      "Edit #{test.title} Question"
    end
  end
end
