class TweetsController < ApplicationController
  def index
    cursor = params[:cursor].present? ? Time.parse(params[:cursor]) : nil
    limit = 10

    user_id = params[:user_id]

    if user_id.present?
      user = User.find_by(id: user_id)
      if user.nil?
        render json: { error: 'Usuário não encontrado' }, status: :not_found and return
      end
      tweets = user.tweets
                   .order(created_at: :desc)
                   .where('created_at < ?', cursor || Time.now)
                   .limit(limit)
    else
      tweets = Tweet
               .order(created_at: :desc)
               .where('created_at < ?', cursor || Time.now)
               .limit(limit)
    end

    next_cursor = tweets.last&.created_at

    render json: {
      tweets: tweets,
      next_cursor: next_cursor
    }
  end
end
