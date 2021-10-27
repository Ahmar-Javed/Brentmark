# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password,
            format: { with: /(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*\d){1,})(?=(.*\W){1,})(?!.*\s).{8,}/,
                      message: ' -Password must contain at least (1) special characters. Password must contain at least (1) uppercase letter. Password must contain at least (1) lowercase letter. Password must be at least 8 characters long.' }
end
