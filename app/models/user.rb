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

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得(自分がフォローしてる人)
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得(自分をフォローしてる人)
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人(の一覧)
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人(フォロワーの一覧)

  # フォローしますというアクション
  def follow(user_id)
    follower.create(followed_id: user_id)
  end
  # ユーザーのフォローを外すアクション
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  # フォローしていればtrueを返す(フォローしてるユーザーを含みますか？)
  def following?(user)
    following_user.include?(user)
  end

end
