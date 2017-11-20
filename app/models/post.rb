class Post < ApplicationRecord

  acts_as_votable

	belongs_to :user
	has_many :comments, dependent: :destroy

	validates :image, presence: true
	validates :user_id, presence: true
  validates :date, presence: true
  validates :caption, length: {maximum: 250}

	has_attached_file :image, styles: { :medium => '640x' }
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

	scope :of_family_members, -> (family_members) { where user_id: family_members }

end