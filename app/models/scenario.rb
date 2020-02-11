class Scenario < ApplicationRecord
  belongs_to :user
  has_many :results

  has_secure_password
  attr_accessor :legal
end
