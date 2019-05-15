class User < ApplicationRecord
    attr_accessor :remember_token
    before_create :set_token

    has_many :posts
    has_secure_password

    def set_token
        self.remember_token = new_token
        write_attribute(:remember_digest, Digest::SHA1.hexdigest(remember_token.to_s))
    end

    def remember
        self.remember_token = new_token
        update_attribute(:remember_digest, Digest::SHA1.hexdigest(remember_token.to_s))
    end

    def forget
        update_attribute(:remember_digest, nil)
    end
    
    def new_token
        SecureRandom.urlsafe_base64
    end

    def authenticated?(remember_token)
        return false if self.remember_digest.nil?
        self.remember_digest == Digest::SHA1.hexdigest(remember_token)
    end

end
