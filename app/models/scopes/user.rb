module Scopes
  module User
    extend ActiveSupport::Concern

    included do
      scope :by_company, -> (identifier) { where(company: identifier) if identifier.present? }
      scope :by_username, -> (username) { where('username LIKE ?', "%#{username}%") if username.present? }
      scope :with_tweets, -> (user_id) { tweets.where(user_id: user_id) }
    end
  end
end
