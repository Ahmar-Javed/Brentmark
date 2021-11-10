class User < ApplicationRecord
 
  include PgSearch::Model

  pg_search_scope :search_users, :against => [:username]
  
  attr_accessor :login

  enum role: [:client, :admin]

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  def password_validation
    rules = {
      'must contain at least one lowercase letter'  => /[a-z]+/,
      'must contain at least one uppercase letter'  => /[A-Z]+/,
      'must contain at least one digit'             => /\d+/,
      'must contain at least one special character' => /[^A-Za-z0-9]+/
    }

    rules.each do |message, regex|
     return errors.add(:password, message) unless password.match(regex)
    end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
    where("lower(username) = :value OR lower(email) = :value", { value: login.downcase }).first
    else
    where(conditions).first
    end
  end
  
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names) 
      end
    end
  end  

  def self.password
  SecureRandom.alphanumeric() + ["!","@","$","%"].sample(1).join
  end

end
