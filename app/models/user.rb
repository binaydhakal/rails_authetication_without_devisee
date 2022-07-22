class User < ApplicationRecord
    # has_many :friend, dependent :destroy
    attr_accessor :remember_token
    before_save :casedown_email

    has_secure_password

    validates :email, presence: true, format: { with: /\A[^@\$]+@[^@\$]+\z/, message: "must be a valid email address" }, uniqueness: true
    validates :password, presence: true, length: {minimum: 5, maximum: 10}

    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def self.new_token
        SecureRandom.urlsafe_base64
    end


    def casedown_email 
        self.email = email.downcase
    end

    def remember 
        self.remember_token = self.new_token
        update_attribute(:remember_digest, self.digest(remember_token))
    end

    def authenticated?(remember_token) 
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

end
