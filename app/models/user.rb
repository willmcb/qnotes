class User < ApplicationRecord
  has_many :notes, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  has_secure_password
end
