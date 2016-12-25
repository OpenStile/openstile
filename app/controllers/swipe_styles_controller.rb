class SwipeStylesController < ApplicationController
  http_basic_authenticate_with name: "admin", password: ENV["RESULTS_PASSWORD"], only: :results

  def invite
    new_style_quiz = InterestSwiperQuiz::Session.create(email: params[:email], first_name: params[:first_name], last_name: params[:last_name])
    if new_style_quiz.valid?
      ShopperMailer.invite_shopper_interest(params[:first_name], params[:email]).deliver
      render json: {status: :ok}
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  def new
    if params[:token].blank?
      redirect_to root_path
    else
      email = Base64.decode64(params[:token])
      @session = InterestSwiperQuiz::Session.find_or_create_by(email: email)
      @session.likes.destroy_all
    end
  end

  def like
    session = InterestSwiperQuiz::Session.find(params[:session_id])
    session.likes.create(style_id: params[:style_id])
    render json: {status: :ok}
  end

  def complete
    session = InterestSwiperQuiz::Session.find(params[:session_id])
    session.update(completed: true)
    render json: {status: :ok}
  end
end
