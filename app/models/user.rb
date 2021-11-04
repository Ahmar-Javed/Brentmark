class User < ApplicationRecord
  invitable named_by: :username

  include Invitation::User

  include PgSearch::Model
  attr_accessor :login

  enum role: [:client, :admin]

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
   
  pg_search_scope :search, :against => [:username]

  def password_validation
    rules = {
      'must contain at least one lowercase letter'  => /[a-z]+/,
      'must contain at least one uppercase letter'  => /[A-Z]+/,
      'must contain at least one digit'             => /\d+/,
      'must contain at least one special character' => /[^A-Za-z0-9]+/
    }

    rules.each do |message, regex|
      errors.add(:password, message) unless password.match(regex)
    end
    validate :password_validation
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
   end
  end
  
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |user|
        csv<< user.attributes.values_at(*column_names) 
      end
    end
  end  
end
