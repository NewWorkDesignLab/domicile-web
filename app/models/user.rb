class User < ApplicationRecord
  has_many :results
  has_many :scenarios

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :trackable
end
