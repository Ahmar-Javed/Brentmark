class User < ApplicationRecord
  include PgSearch::Model
  after_create :create_empty_cart
  has_one :cart

  has_many :orders

  pg_search_scope :search_users, against: [:username, :firstname, :id, :email]
  
  attr_accessor :login

  enum role: [:client, :admin]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates_format_of :phone, with: /^[0-9]{11}$/, :multiline => true

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
  
  def create_empty_cart
    self.create_cart
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

  def self.invite(user_params)
    @user = User.new(user_params)
    @password = User.password
    @user.password = @password
    @user.password_confirmation = @password
    @user.status= true
    @user.skip_confirmation!
    if @user.save   
      UserMailer.with(user: @user, password: @password).welcome_email.deliver_now
      return true
    end
  end
end
