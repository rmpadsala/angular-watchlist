class User < ActiveRecord::Base
  has_many :watched_symbols, dependent: :destroy
end
