class User < ApplicationRecord
  has_many :scenarios
  has_many :results

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :trackable
end
