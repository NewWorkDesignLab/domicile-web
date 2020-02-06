class Scenario < ApplicationRecord
  belongs_to :user
  has_many :results

  has_secure_password :password, validations: false
  attr_accessor :legal
end
