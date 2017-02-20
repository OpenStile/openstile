class SwipeStylesController < ApplicationController
  http_basic_authenticate_with name: "admin", password: ENV["RESULTS_PASSWORD"], only: :results

  def invite
    new_profile = InterestSwiperQuiz::Profile.create(email: params[:email], first_name: params[:first_name], last_name: params[:last_name])
    if new_profile.valid?
      ShopperMailer.invite_shopper_interest(params[:first_name], params[:email]).deliver
      render json: {status: :ok}
    else
      render json: {status: :error, message: new_profile.errors.full_messages.join('. ')}
    end
  end

  def new
    if params[:token].blank?
      redirect_to root_path
    else
      email = Base64.decode64(params[:token])
      profile = InterestSwiperQuiz::Profile.find_or_create_by(email: email)
      @session = profile.sessions.create(completed: false)
    end
  end

  def like
    session = InterestSwiperQuiz::Session.find(params[:session_id])
    session.likes.create(style_id: params[:style_id])
    render json: {status: :ok}
  end

  def complete
    session = InterestSwiperQuiz::Session.find(params[:session_id])
    if params[:like_ids]
      params[:like_ids].each do |id|
        session.likes.create(style_id: id)
      end
    end
    session.update(completed: true)
    render json: {status: :ok}
  end

  def destroy
    session = InterestSwiperQuiz::Session.find(params[:session_id])
    session.destroy
    redirect_to swipe_styles_results_path
  end

  def update_matches
    profile = InterestSwiperQuiz::Profile.find(params[:profile_id])
    profile.update_attribute(:retailer_matches, params[:match_string])
    render json: {status: :ok, updated_profile: profile.reload}
  end

  def update_style_needs
    profile = InterestSwiperQuiz::Profile.find(params[:profile_id])
    profile.update_attribute(:needs, params[:data])
    render json: {status: :ok}
  end
end
