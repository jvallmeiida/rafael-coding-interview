class User < ApplicationRecord
  include Scopes::User

  belongs_to :company
  has_many :tweets
end
