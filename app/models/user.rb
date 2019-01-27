class User < ApplicationRecord
  has_many :notes, dependent: :destroy
  has_many :collections, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  has_secure_password

  after_create :create_default_collection

  private

  def create_default_collection
    @user = User.all.last
    @user.collections.create(name: 'default')
  end
end
