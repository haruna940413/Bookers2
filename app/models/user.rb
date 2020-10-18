class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :introduction, {length:{maximum:50}}
  validates :name, {presence: true, length: {minimum: 2, maximum: 20}}
  attachment :profile_image

  has_many :books, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
