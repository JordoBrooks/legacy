class Kinship < ApplicationRecord
  belongs_to :user
  belongs_to :family, class_name: 'User'
end
