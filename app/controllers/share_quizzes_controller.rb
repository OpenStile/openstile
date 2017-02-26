class ShareQuizzesController < ApplicationController
  def show
    @quiz = ShareQuiz.find_by_name(params[:name])
    @categorizations = {}
    @results = {}
    @quiz.share_quiz_categorizations.shuffle.each do |cat|
      @categorizations[cat.name] = cat.options['images'].shuffle
      @results[cat.name] = {image: cat.result_url, description: cat.description}
    end
  end
end