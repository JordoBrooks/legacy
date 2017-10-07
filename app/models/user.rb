class User < ApplicationRecord

  before_save {self.email.downcase!}

  has_attached_file :image, styles: { :thumb => '100x100' }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates :first_name, presence: true, length: {maximum: 20}
  validates :last_name, presence: true, length: {maximum: 20}

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
                    format: {with: EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, presence: true, length: {minimum: 6}
end
