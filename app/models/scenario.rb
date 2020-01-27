class Scenario < ApplicationRecord
  has_secure_password :password, validations: false
end
