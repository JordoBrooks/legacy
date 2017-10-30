class User < ApplicationRecord
  include AuthenticationHelper

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  attr_accessor :remember_token

  before_save {self.email.downcase!}

  has_attached_file :image, styles: { thumb: '50x50', medium: '250x250' }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates :first_name, presence: true, length: {maximum: 20}
  validates :last_name, presence: true, length: {maximum: 20}

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
                    format: {with: EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, presence: true, length: {minimum: 6}

  # remember user in database for use in persistent session
  def remember
    self.remember_token = new_token
    update_attribute(:remember_digest, digest(remember_token))
  end

  # forget a user
  def forget
    update_attribute(:remember_digest, nil)
  end

  # return true if the given token matches the digest
  def authenticated?(token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(token)
  end
end
